import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/components/SearchBox.dart';
import 'package:speedypizza_web/provider/customers_info.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:speedypizza_web/components/SideMenu.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;
import 'DetailsScreen.dart';

class CustomersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: SideMenu(
        selectedIndex: 3,
      ),
      appBar: AppBar(
        title: Text("Clienti"),
      ),
      body: ChangeNotifierProvider(
          child: CustomersBody(), create: (context) => CustomersInfo()),
    );
  }
}

class CustomersBody extends StatelessWidget {
  const CustomersBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var queryingStream;
    double delay = 0;

    return Consumer<CustomersInfo>(builder: (context, data, index) {
      if (data.isQuerying) {
        queryingStream = FirebaseFirestore.instance
            .collection("customers")
            .where("surname",
                isGreaterThanOrEqualTo:
                    data.surnameController.text.toLowerCase())
            .snapshots();
        delay = 0;
      } else {
        queryingStream =
            FirebaseFirestore.instance.collection("customers").snapshots();
        delay = 0;
      }

      return Column(
        children: [
          SlideYFadeIn(1.5, SearchBox()),
          Container(height: 20),
          SlideYFadeInBottom(
            3.5, Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4, vertical: 10),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: darkGrey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container()),
                      Expanded(
                          flex: 3,
                          child: Text(
                              "Cognome",
                              style: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.w600))),
                      Expanded(
                          flex: 3,
                          child: Text("Telefono",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600))),
                      Opacity(
                        opacity: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: FloatingActionButton(
                              onPressed: () {
                              },
                              heroTag: null,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(7.0))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder(
              stream: queryingStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data.docs.map((document) {
                          delay += 0.4;
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width / 4, vertical: 10),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: darkGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Icon(Icons.person,
                                              color: Colors.grey)),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                              document
                                                  .data()["surname"]
                                                  .toString()
                                                  .inCaps,
                                              style: TextStyle(
                                                  color: Colors.grey))),
                                      Expanded(
                                          flex: 3,
                                          child: Text(document.data()["phone"],
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 11),
                                        child: FloatingActionButton(
                                            onPressed: () {
                                              globals.surname = document.data()["surname"];
                                              globals.phone = document.data()["phone"];
                                              globals.address = document.data()["address"];
                                              globals.doorno = document.data()["doorno"];
                                              globals.floor = document.data()["floor"];
                                              globals.credit = document.data()["credit"];
                                              globals.discount = document.data()["discount"];

                                              Navigator.pushReplacementNamed(context, DetailsScreenRoute, arguments: DetailsArgs(globals.phone, false, true, false));
                                            },
                                            backgroundColor: Colors.deepPurple,
                                            heroTag: null,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(7.0),
                                              child: Image.asset(
                                                  "images/edit.png"),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          );
                        }).toList()),
                  );
                }
              }),
          Container(height: MediaQuery.of(context).size.height * 0.05)
        ],
      );
    });
  }
}