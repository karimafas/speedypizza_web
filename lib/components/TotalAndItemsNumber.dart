import 'package:flutter/material.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

class TotalAndItemsNumber extends StatelessWidget {
  const TotalAndItemsNumber({
    Key key, this.data,
  }) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Prodotti: " + data.cart.length.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Sconto:",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 13)),
                  Container(height: 5),
                  Text("Credito: €",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 13)),
                  Container(height: 5),
                  Text("Totale: €",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16)),
                ],
              ),
              Container(width: 15),
              Container(
                width: 2,
                height: 30,
                color: Colors.grey,
              ),
              Container(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      globals.discount != ""
                          ? globals.discount + "%"
                          : "",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 13)),
                  Container(height: 5),
                  Text(
                      globals.credit != ""
                          ? double.parse(globals.credit)
                          .toStringAsFixed(2)
                          : "",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 13)),
                  Container(height: 5),
                  Text(data.total.toStringAsFixed(2),
                      style: TextStyle(
                          color: Colors.white, fontSize: 16)),
                ],
              ),
            ],
          ),
          //Container(width: 30),
        ]);
  }
}