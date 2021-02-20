import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:flutter/material.dart' as material;
import 'package:speedypizza_web/globals/globals.dart' as globals;

Future<Uint8List> generatePdf(
    material.BuildContext context,
    String deliveryTime,
    String timeNow,
    bool cashPayment,
    String notes,
    String date,
    int orderNumber) async {
  final pdf = Document();
  var provider = Provider.of<Cart>(context, listen: false);

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Data: " + date + ", ore: " + timeNow),
                          Text("Orario consegna: " + deliveryTime),
                        ],
                      ),
                      Container(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(globals.surname),
                          Text("Telefono: " + globals.phone),
                        ],
                      ),
                      Container(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(globals.address + ", " + globals.doorno),
                          Text("Piano: " + globals.floor),
                        ],
                      ),
                      Container(height: 2),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(notes.isNotEmpty ? "Note: " + notes : ""),
                          Container(height: 2),
                          Text("Ordine #" + orderNumber.toString())
                        ],
                      ),
                      Container(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 150,
                          width: 400,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                if (index < 10) {
                                  String recapMods = "";

                                  List mods = json.decode(
                                      provider.groupedCart[index][0][2]);

                                  if (mods.isNotEmpty) {
                                    List modsNames = [];

                                    for (int i = 0; i < mods.length; i++) {
                                      modsNames.add(mods[i][0]);
                                    }

                                    recapMods = "";
                                    for (int i = 0; i < modsNames.length; i++) {
                                      recapMods +=
                                          (modsNames[i]).toLowerCase() + ", ";
                                    }

                                    recapMods = recapMods.substring(
                                        0, recapMods.length - 2);
                                  }

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Center(
                                              child: Text(provider
                                                  .groupedCart[index][1][0]
                                                  .toString())),
                                          Container(width: 10),
                                          Text(provider.groupedCart[index][0]
                                              [0]),
                                          Container(width: 30),
                                          Text(recapMods.isNotEmpty
                                              ? " ($recapMods)"
                                              : ""),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(provider.groupedCart[index][1][0]
                                                  .toString() +
                                              "x " +
                                              double.parse(provider
                                                      .groupedCart[index][0][1])
                                                  .toStringAsFixed(2))
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              },
                              separatorBuilder: (context, index) {
                                return Container(height: 1);
                              },
                              itemCount: provider.groupedCart.length),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cashPayment
                                    ? "Pagamento in contanti."
                                    : "Pagamento in carta."),
                                Text(provider.groupedCart.length > 9 ? "Pagina 1/2" : "Pagina 1/2"),
                              ]
                          ),
                          Text("Totale prodotti: " +
                              provider.cart.length.toString()),
                          Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sub-totale:"),
                                    Text("Credito:"),
                                    Text("Sconto (%):"),
                                    Text("Totale:"),
                                  ]),
                              Container(
                                width: 15,
                              ),
                              Container(
                                width: 2,
                                height: 50,
                                color: PdfColor.fromInt(0xff9e9e9e),
                              ),
                              Container(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(provider.total.toStringAsFixed(2)),
                                  Text("-" +
                                      double.parse(globals.credit)
                                          .toStringAsFixed(2)),
                                  Text(globals.discount + ""),
                                  Text(provider.total.toStringAsFixed(2)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
              Container(height: 100),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Data: " + date + ", ore: " + timeNow),
                          Text("Orario consegna: " + deliveryTime),
                        ],
                      ),
                      Container(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(globals.surname),
                          Text("Telefono: " + globals.phone),
                        ],
                      ),
                      Container(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(globals.address + ", " + globals.doorno),
                          Text("Piano: " + globals.floor),
                        ],
                      ),
                      Container(height: 2),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(notes.isNotEmpty ? "Note: " + notes : ""),
                          Container(height: 2),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Ordine #" + orderNumber.toString()),
                              ])
                        ],
                      ),
                      Container(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 150,
                          width: 400,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                if (index < 10) {
                                  String recapMods = "";

                                  List mods = json.decode(
                                      provider.groupedCart[index][0][2]);

                                  if (mods.isNotEmpty) {
                                    List modsNames = [];

                                    for (int i = 0; i < mods.length; i++) {
                                      modsNames.add(mods[i][0]);
                                    }

                                    recapMods = "";
                                    for (int i = 0; i < modsNames.length; i++) {
                                      recapMods +=
                                          (modsNames[i]).toLowerCase() + ", ";
                                    }

                                    recapMods = recapMods.substring(
                                        0, recapMods.length - 2);
                                  }

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Center(
                                              child: Text(provider
                                                  .groupedCart[index][1][0]
                                                  .toString())),
                                          Container(width: 10),
                                          Text(provider.groupedCart[index][0]
                                              [0]),
                                          Container(width: 30),
                                          Text(recapMods.isNotEmpty
                                              ? " ($recapMods)"
                                              : ""),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(provider.groupedCart[index][1][0]
                                                  .toString() +
                                              "x " +
                                              double.parse(provider
                                                      .groupedCart[index][0][1])
                                                  .toStringAsFixed(2))
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return Text("");
                                }
                              },
                              separatorBuilder: (context, index) {
                                return Container(height: 1);
                              },
                              itemCount: provider.groupedCart.length),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cashPayment
                                    ? "Pagamento in contanti."
                                    : "Pagamento in carta."),
                                Text(provider.groupedCart.length > 9 ? "Pagina 1/2" : "Pagina 1/2"),
                              ]
                          ),
                          Text("Totale prodotti: " +
                              provider.cart.length.toString()),
                          Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sub-totale:"),
                                    Text("Credito:"),
                                    Text("Sconto (%):"),
                                    Text("Totale:"),
                                  ]),
                              Container(
                                width: 15,
                              ),
                              Container(
                                width: 2,
                                height: 50,
                                color: PdfColor.fromInt(0xff9e9e9e),
                              ),
                              Container(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(provider.total.toStringAsFixed(2)),
                                  Text("-" +
                                      double.parse(globals.credit)
                                          .toStringAsFixed(2)),
                                  Text(globals.discount + ""),
                                  Text(provider.total.toStringAsFixed(2)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
            ]);
      },
    ),
  );

  if(provider.groupedCart.length > 10) {
    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Data: " + date + ", ore: " + timeNow),
                            Text("Orario consegna: " + deliveryTime),
                          ],
                        ),
                        Container(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(globals.surname),
                            Text("Telefono: " + globals.phone),
                          ],
                        ),
                        Container(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(globals.address + ", " + globals.doorno),
                            Text("Piano: " + globals.floor),
                          ],
                        ),
                        Container(height: 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(notes.isNotEmpty ? "Note: " + notes : ""),
                            Container(height: 5),
                            Text("Ordine #" + orderNumber.toString())
                          ],
                        ),
                        Container(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            height: 150,
                            width: 400,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if(index > 9) {
                                    String recapMods = "";

                                    List mods = json.decode(
                                        provider.groupedCart[index][0][2]);

                                    if (mods.isNotEmpty) {
                                      List modsNames = [];

                                      for (int i = 0; i < mods.length; i++) {
                                        modsNames.add(mods[i][0]);
                                      }

                                      recapMods = "";
                                      for (int i = 0; i < modsNames.length; i++) {
                                        recapMods +=
                                            (modsNames[i]).toLowerCase() + ", ";
                                      }

                                      recapMods = recapMods.substring(
                                          0, recapMods.length - 2);
                                    }

                                    return Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Center(
                                                child: Text(provider
                                                    .groupedCart[index][1][0]
                                                    .toString())),
                                            Container(width: 10),
                                            Text(provider.groupedCart[index][0]
                                            [0]),
                                            Container(width: 30),
                                            Text(recapMods.isNotEmpty
                                                ? " ($recapMods)"
                                                : ""),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(provider.groupedCart[index][1][0]
                                                .toString() +
                                                "x " +
                                                double.parse(provider
                                                    .groupedCart[index][0][1])
                                                    .toStringAsFixed(2))
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                  else {
                                    return Container(height: 1);
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return Container(height: 1);
                                },
                                itemCount: provider.groupedCart.length),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cashPayment
                                      ? "Pagamento in contanti."
                                      : "Pagamento in carta."),
                                  Text("Pagina 2/2"),
                                ]
                            ),
                            Text("Totale prodotti: " +
                                provider.cart.length.toString()),
                            Row(
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sub-totale:"),
                                      Text("Credito:"),
                                      Text("Sconto (%):"),
                                      Text("Totale:"),
                                    ]),
                                Container(
                                  width: 15,
                                ),
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: PdfColor.fromInt(0xff9e9e9e),
                                ),
                                Container(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(provider.total.toStringAsFixed(2)),
                                    Text("-" +
                                        double.parse(globals.credit)
                                            .toStringAsFixed(2)),
                                    Text(globals.discount + ""),
                                    Text(provider.total.toStringAsFixed(2)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
                Container(height: 100),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Data: " + date + ", ore: " + timeNow),
                            Text("Orario consegna: " + deliveryTime),
                          ],
                        ),
                        Container(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(globals.surname),
                            Text("Telefono: " + globals.phone),
                          ],
                        ),
                        Container(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(globals.address + ", " + globals.doorno),
                            Text("Piano: " + globals.floor),
                          ],
                        ),
                        Container(height: 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(notes.isNotEmpty ? "Note: " + notes : ""),
                            Container(height: 2),
                            Text("Ordine #" + orderNumber.toString())
                          ],
                        ),
                        Container(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            height: 150,
                            width: 400,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if(index > 9) {
                                    String recapMods = "";

                                    List mods = json.decode(
                                        provider.groupedCart[index][0][2]);

                                    if (mods.isNotEmpty) {
                                      List modsNames = [];

                                      for (int i = 0; i < mods.length; i++) {
                                        modsNames.add(mods[i][0]);
                                      }

                                      recapMods = "";
                                      for (int i = 0; i < modsNames.length; i++) {
                                        recapMods +=
                                            (modsNames[i]).toLowerCase() + ", ";
                                      }

                                      recapMods = recapMods.substring(
                                          0, recapMods.length - 2);
                                    }

                                    return Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Center(
                                                child: Text(provider
                                                    .groupedCart[index][1][0]
                                                    .toString())),
                                            Container(width: 10),
                                            Text(provider.groupedCart[index][0]
                                            [0]),
                                            Container(width: 30),
                                            Text(recapMods.isNotEmpty
                                                ? " ($recapMods)"
                                                : ""),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(provider.groupedCart[index][1][0]
                                                .toString() +
                                                "x " +
                                                double.parse(provider
                                                    .groupedCart[index][0][1])
                                                    .toStringAsFixed(2))
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                  else {
                                    return Container(height: 1);
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return Container(height: 1);
                                },
                                itemCount: provider.groupedCart.length),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cashPayment
                                    ? "Pagamento in contanti."
                                    : "Pagamento in carta."),
                                Text("Pagina 2/2"),
                              ]
                            ),
                            Text("Totale prodotti: " +
                                provider.cart.length.toString()),
                            Row(
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sub-totale:"),
                                      Text("Credito:"),
                                      Text("Sconto (%):"),
                                      Text("Totale:"),
                                    ]),
                                Container(
                                  width: 15,
                                ),
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: PdfColor.fromInt(0xff9e9e9e),
                                ),
                                Container(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(provider.total.toStringAsFixed(2)),
                                    Text("-" +
                                        double.parse(globals.credit)
                                            .toStringAsFixed(2)),
                                    Text(globals.discount + ""),
                                    Text(provider.total.toStringAsFixed(2)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ]);
        },
      ),
    );
  }

  return pdf.save();
}
