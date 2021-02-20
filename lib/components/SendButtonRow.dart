import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;
import 'package:speedypizza_web/components/PdfPage.dart' as pdfGenerator;
import 'package:speedypizza_web/screens/ArchiveScreen.dart' as archiveScreen;

class SendButtonRow extends StatelessWidget {
  const SendButtonRow({
    Key key,
    @required TextEditingController notesController,
    @required DateFormat dateFormat, this.data,
  }) : _notesController = notesController, _dateFormat = dateFormat, super(key: key);

  final TextEditingController _notesController;
  final DateFormat _dateFormat;
  final data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          children: <Widget>[
            Tooltip(child: Icon(Icons.money), message: "Contanti"),
            Tooltip(
                child: Icon(Icons.credit_card), message: "Carta"),
          ],
          isSelected: data.cashCardSelection,
          onPressed: (int index) {
            data.setCashCardSelection(index);
          },
        ),
        Container(width: 50),
        SizedBox(
          height: 70,
          width: 70,
          child: Tooltip(
            child: FloatingActionButton(
                onPressed: () async {
                  if (data.cart.length < 1 || !data.hasChosenTime) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          if (data.cart.length < 1) {
                            return AlertDialog(
                              title: Text('Errore'),
                              content: Text(
                                  'Aggiungi un prodotto al carrello.'),
                              actions: [
                                ElevatedButton(
                                  child: Text("OK"),
                                  onPressed: () =>
                                      Navigator.pop(context),
                                )
                              ],
                            );
                          }
                          if (!data.hasChosenTime) {
                            return AlertDialog(
                              title: Text('Errore'),
                              content: Text(
                                  'Scegli un orario di consegna.'),
                              actions: [
                                ElevatedButton(
                                  child: Text("OK"),
                                  onPressed: () =>
                                      Navigator.pop(context),
                                )
                              ],
                            );
                          }
                        });
                  } else {
                    var timeNow = TimeOfDay.now().format(context);

                    DateFormat dateFormat =
                    DateFormat("dd-MM-yyyy");

                    if (data.isReopeningOrder) {
                      var result = await FirebaseFirestore.instance
                          .collection("orders")
                          .where("timePlaced", isEqualTo: globals.timePlaced)
                          .where("datePlaced",
                          isEqualTo: globals.datePlaced)
                          .limit(1)
                          .get()
                          .then((query) {
                        var order = query.docs[0];
                        order.reference.update({
                          "timePlaced": globals.timePlaced,
                          "datePlaced":
                          globals.datePlaced,
                          "deliveryTime":
                          data.deliveryTime.format(context),
                          "phone": globals.phone,
                          "nameSurname":
                          globals.surname,
                          "order": json.encode(data.cart),
                          "total": data.total,
                          "cash": data.cashCardSelection[0] ? true : false,
                          "notes": _notesController.text,
                          "wasEdited" : true,
                          "pony": "",
                          "timeDelivered": ""
                        });
                      });
                    }
                    else {
                      FirebaseFirestore.instance
                          .collection("orders")
                          .add({
                        "timePlaced": timeNow,
                        "datePlaced":
                        dateFormat.format(DateTime.now()),
                        "deliveryTime":
                        data.deliveryTime.format(context),
                        "phone": globals.phone,
                        "nameSurname":
                        globals.surname,
                        "order": json.encode(data.cart),
                        "total": data.total,
                        "cash": data.cashCardSelection[0] ? true : false,
                        "notes": _notesController.text,
                        "wasEdited": false,
                        "pony": "",
                        "timeDelivered": "",
                        "orderNumber": globals.orderNumber
                      });
                    }

                    data.groupItems();

                    Provider.of<Cart>(context, listen: false).updateCreditDatabase(globals.phone);

                    final title = 'SpeedyPizza_Order';
                    await Printing.layoutPdf(
                        onLayout: (format) =>
                            pdfGenerator.generatePdf(
                                context,
                                data.deliveryTime.format(context),
                                timeNow,
                                data.cashCardSelection[0] ? true : false,
                                _notesController.text,
                                data.isReopeningOrder ? globals.datePlaced : _dateFormat.format(DateTime.now()),
                            data.isReopeningOrder ? globals.reopenedOrderNumber : globals.orderNumber));

                    data.clear();
                    globals.clear();
                    archiveScreen.setHasChanges(context, true);

                    //Update database order number
                    if(!Provider.of<Cart>(context, listen: false).isReopeningOrder)
                    {
                      if(globals.orderNumber != 1) {
                        var result = await FirebaseFirestore.instance
                            .collection("ordernumbers")
                            .where("date", isEqualTo: _dateFormat.format(DateTime.now()))
                            .limit(1)
                            .get()
                            .then((query) {
                          var order = query.docs[0];
                          order.reference.update({
                            "ordernumber" : globals.orderNumber,
                          });
                        });
                      }
                      else {
                        FirebaseFirestore.instance
                            .collection("ordernumbers")
                            .add({
                          "date":
                          dateFormat.format(DateTime.now()),
                          "ordernumber":
                          globals.orderNumber
                        });
                      }
                      globals.orderNumber += 1;
                    }
                    Navigator.pushReplacementNamed(context, data.isReopeningOrder? ArchiveScreenRoute : HomeScreenRoute);
                  }
                },
                heroTag: null,
                child: Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Image.asset("images/send.png"),
                )),
            message: "Invia ordine",
          ),
        ),
      ],
    );
  }
}