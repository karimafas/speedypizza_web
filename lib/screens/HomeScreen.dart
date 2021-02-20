import 'dart:convert';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/archive.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:speedypizza_web/components/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/screens/DetailsScreen.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/SpeedyButton.dart';
import 'package:speedypizza_web/components/SpeedyField.dart';
import 'package:transparent_image/transparent_image.dart';
import 'ArchiveScreen.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

TextEditingController phoneController = new TextEditingController();
bool thereIsOrder;
String prevOrderTime = "";

void updateGlobals(BuildContext context) {
  var provider = Provider.of<Archive>(context, listen: false);

  globals.reopenedOrderNumber = provider.singleOrder[0][12];

  Provider.of<Cart>(context, listen: false)
      .reopenCart(json.decode(provider.singleOrder[0][4]));

  Provider.of<Cart>(context, listen: false).getModsList(0);

  globals.timePlaced = provider.singleOrder[0][0];
  globals.datePlaced = provider.singleOrder[0][9];

  Provider.of<Cart>(context, listen: false).switchIsReopeningOrder(true);

  String sTime = provider.singleOrder[0][1];
  Provider.of<Cart>(context, listen: false).setTime(TimeOfDay(
      hour: int.parse(sTime.split(":")[0]),
      minute: int.parse(sTime.split(":")[1])));
  Provider.of<Cart>(context, listen: false).switchHasChosenTime(true);

  bool isCash = provider.singleOrder[0][7];
  Provider.of<Cart>(context, listen: false)
      .setCashCardSelection(isCash ? 0 : 1);

  Provider.of<Cart>(context, listen: false)
      .setNotes(provider.singleOrder[0][6]);

  Provider.of<Cart>(context, listen: false)
      .setTotal(double.parse(provider.singleOrder[0][5]));
}

Future<void> findPreviousOrder() async {
  thereIsOrder = false;

  var result = await FirebaseFirestore.instance
      .collection("orders")
      .where("datePlaced", isEqualTo: dateFormat.format(DateTime.now()))
      .where("phone", isEqualTo: phoneController.text)
      .get();
  result.docs.forEach((result) {
    if (result.data()["order"] != null) {
      thereIsOrder = true;
      prevOrderTime = result.data()["timePlaced"];
    }
  });
}

Future<void> getSingleOrder(BuildContext context) async {
  var result = await FirebaseFirestore.instance
      .collection("orders")
      .where("datePlaced", isEqualTo: dateFormat.format(DateTime.now()))
      .where("phone", isEqualTo: phoneController.text)
      .get();

  result.docs.forEach((result) {
    if (result.data()["order"] != null) {
      Provider.of<Archive>(context, listen: false).addSingleOrder(
        result.data()["timePlaced"],
        result.data()["deliveryTime"],
        result.data()["phone"].toString(),
        result.data()["nameSurname"].toString().inCaps,
        result.data()["order"].toString(),
        result.data()["total"].toString(),
        result.data()["notes"].toString(),
        result.data()["cash"],
        result.data()["wasEdited"],
        result.data()["datePlaced"],
        result.data()["pony"],
        result.data()["timeDelivered"],
        result.data()["orderNumber"],
      );

      globals.notes = result.data()["notes"].toString();
    }
  });
}

void navigate(BuildContext context) {
  var provider = Provider.of<Archive>(context, listen: false);

  if (!thereIsOrder) {
    Navigator.pushNamed(context, DetailsScreenRoute,
        arguments: DetailsArgs(phoneController.text, false, false, true));
  } else {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Ordine trovato'),
            content: Text(
                'Questo cliente ha già effettuato un ordine alle $prevOrderTime.\nCome desideri procedere?'),
            actions: [
              ElevatedButton(
                  child: Text("Crea nuovo"),
                  onPressed: () {
                    globals.notes = "";
                    Navigator.pop(context);
                    Navigator.pushNamed(context, DetailsScreenRoute,
                        arguments: DetailsArgs(
                            phoneController.text, false, false, true));
                  }),
              ElevatedButton(
                child: Text("Modifica esistente"),
                onPressed: () {
                  runOneByOne<void>([
                    () => getSingleOrder(context),
                    () => updateGlobals(context),
                    () => fetchCustomerData(context, 0, provider.singleOrder),
                    () => Navigator.pop(context),
                    () => Navigator.pushNamed(context, ReviewScreenRoute),
                    () => phoneController.clear()
                  ]);
                },
              ),
              ElevatedButton(
                  child: Text("Elimina esistente"),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Vuoi continuare?'),
                            content: Text(
                                "L'eliminazione è irreversibile.\nDesideri procedere?"),
                            actions: [
                              ElevatedButton(
                                  child: Text("Annulla"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              ElevatedButton(
                                  child: Text("Elimina"),
                                  onPressed: () async {
                                    var result = await FirebaseFirestore
                                        .instance
                                        .collection("orders")
                                        .where("datePlaced",
                                            isEqualTo: dateFormat
                                                .format(DateTime.now()))
                                        .where("phone",
                                            isEqualTo: phoneController.text)
                                        .get();

                                    result.docs.forEach((element) {
                                      element.reference.delete();
                                    });
                                    thereIsOrder = false;
                                    phoneController.clear();
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    final snackBar = SnackBar(
                                      content: Text(
                                          'Ordine eliminato con successo.'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }),
                            ],
                          );
                        });
                  })
            ],
          );
        });
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(selectedIndex: 0),
        appBar: AppBar(),
        backgroundColor: backgroundColor,
        body: HomeBody());
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            0.5,
            SizedBox(
              child: FadeInImage.memoryNetwork(
                  image: "https://i.ibb.co/JyHDxWv/logo.png",
                  placeholder: kTransparentImage),
              height: 200,
              width: 200,
            ),
          ),
          FadeIn(1, PhoneFieldAndLabel(phoneController: phoneController)),
          FadeIn(
            1.5,
            Padding(
                padding: const EdgeInsets.only(top: 50),
                child: speedyButton(
                  width: 100,
                  text: "Avanti >",
                  color: Colors.white,
                  pressed: () {
                    if (phoneController.text != "") {
                      runOneByOne<void>(
                          [() => findPreviousOrder(), () => navigate(context)]);
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class PhoneFieldAndLabel extends StatelessWidget {
  const PhoneFieldAndLabel({
    Key key,
    @required this.phoneController,
  }) : super(key: key);

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Text("Inserisci un numero di telefono:",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        speedyField(
            controller: phoneController,
            width: 200,
            submitted: (value) {
              if (value != "") {
                runOneByOne<void>(
                    [() => findPreviousOrder(), () => navigate(context)]);
              }
            }),
      ],
    );
  }
}
