import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:speedypizza_web/components/SideMenu.dart';
import 'ArchiveScreen.dart';

DateTime _selectedDate;
Key _streamKey = Key("stream");

class SpeedyPony extends StatefulWidget {
  @override
  _SpeedyPonyState createState() => _SpeedyPonyState();
}

class _SpeedyPonyState extends State<SpeedyPony> {
  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  String _currentPony = "";
  double itemDelay = 0.5;
  double ponyDelay = 1.5;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    String todaysDate = _dateFormat.format(DateTime.now());
    TextEditingController _ponyName = new TextEditingController();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2015, 1),
          lastDate: DateTime(2100, 1));
      if (picked != null && picked != _selectedDate)
        setState(() {
          _selectedDate = picked;
          _streamKey = UniqueKey();
        });
    }

    return Scaffold(
      drawer: SideMenu(selectedIndex: 4),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Speedy Pony"),
      ),
      body: StreamBuilder(
        key: _streamKey,
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("datePlaced", isEqualTo: _dateFormat.format(_selectedDate))
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    SlideYFadeInBottom(
                      4,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                             _selectDate(context);
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                _dateFormat.format(_selectedDate),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                            height: 70,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: darkGrey),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: TitlesRow(),
                      ),
                    ),
                    buildOrdersList(snapshot, _ponyName, context),
                  ],
                ),
              );
            }
          }),
    );
  }

  ListView buildOrdersList(AsyncSnapshot<QuerySnapshot> snapshot,
      TextEditingController _ponyName, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: snapshot.data.docs.map((document) {
        itemDelay += 1;
        return SlideFadeInRTL(
          itemDelay,
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                if (document.data()["pony"] != "") {
                  _ponyName.text = document.data()["pony"];
                } else {
                  _ponyName.text = "";
                }
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Dettagli pony'),
                          content: Container(
                            height: 90,
                            child: Column(
                              children: [
                                Text('Nominativo pony:'),
                                Container(height: 15),
                                TextField(
                                  autofocus: true,
                                  controller: _ponyName,
                                  onSubmitted: (value) {
                                    setHasChanges(context, true);
                                    document.reference.update({
                                      'pony': _ponyName.text,
                                      'timeDelivered':
                                          TimeOfDay.now().format(context)
                                    });
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text("OK"),
                              onPressed: () {
                                setHasChanges(context, true);
                                document.reference.update({
                                  'pony': _ponyName.text,
                                  'timeDelivered':
                                      TimeOfDay.now().format(context)
                                });
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: darkGrey,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 15,
                                offset:
                                    Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: document.data()["pony"] != ""
                                      ? Colors.deepPurpleAccent
                                      : Colors.grey,
                                ),
                              ),
                              Expanded(child: Container(), flex: 1),
                              Expanded(
                                child: Text(document.data()["deliveryTime"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                flex: 3,
                              ),
                              Expanded(
                                child: Text(document.data()["nameSurname"],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18)),
                                flex: 3,
                              ),
                              Expanded(
                                child: Text(document.data()["phone"].toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                flex: 3,
                              ),
                              Expanded(
                                child: Text(
                                    "€" +
                                        double.parse(document
                                                .data()["total"]
                                                .toString())
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18)),
                                flex: 2,
                              ),
                              Expanded(
                                child: Text(document.data()["timePlaced"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                flex: 2,
                              ),
                            ]),
                          ),
                        ),
                        Container(width: 30),
                        Container(
                          child: SlideFadeIn(
                            5,
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: document.data()["pony"] == "" ? 0 : 1,
                              child: Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(document.data()["pony"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class TitlesRow extends StatelessWidget {
  const TitlesRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 55,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SlideYFadeIn(
              3,
              Container(
                decoration: BoxDecoration(
                  color: darkGrey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 15,
                      width: 15,
                    ),
                    Expanded(child: Container(), flex: 1),
                    Expanded(
                      child: Text("Ora consegna",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      flex: 3,
                    ),
                    Expanded(
                      child: Text("Cliente",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      flex: 3,
                    ),
                    Expanded(
                      child: Text("Telefono",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      flex: 3,
                    ),
                    Expanded(
                      child: Text("Totale",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      flex: 2,
                    ),
                    Expanded(
                      child: Text("Ora ordine",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      flex: 2,
                    ),
                  ]),
                ),
              ),
            ),
            Container(width: 30),
            SlideYFadeIn(
              3.5,
              Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Pony",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
