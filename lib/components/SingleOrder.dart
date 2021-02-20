import 'package:flutter/material.dart';
import 'package:speedypizza_web/theme/style_constants.dart';

class SingleOrder extends StatelessWidget {
  const SingleOrder({
    Key key,
    this.deliveryTime,
    this.productsNumber,
    this.timePlaced,
    this.total,
    this.nameSurname,
    this.phone,
    this.isCash,
    this.pressed,
    this.wasEdited,
    this.pony,
    this.hasLeft,
    this.leftTime,
    this.deleteOrder,
  }) : super(key: key);
  final String deliveryTime;
  final String productsNumber;
  final String timePlaced;
  final String total;
  final String nameSurname;
  final String phone;
  final bool isCash;
  final Function pressed;
  final bool wasEdited;
  final String pony;
  final bool hasLeft;
  final String leftTime;
  final Function deleteOrder;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: true,
      verticalOffset: 80,
      message: !hasLeft
          ? "Consegna alle $deliveryTime"
          : "Consegna alle $deliveryTime \nPartito alle " + leftTime,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: pressed,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(alignment: Alignment.centerRight, children: [
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(timePlaced,
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Container(
                        height: 6,
                      ),
                      Text("€$total",
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: wasEdited ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 17, bottom: 5),
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, bottom: 5),
                        child: SizedBox(
                            width: 15,
                            child: Image.asset(isCash
                                ? "images/cash.png"
                                : "images/card.png")),
                      ),
                      Opacity(
                        opacity: pony != "" ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 17, bottom: 0),
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        phone,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      Container(height: 6),
                      Text(
                        nameSurname,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FloatingActionButton(
                    onPressed: deleteOrder,
                    backgroundColor: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("images/close.png"),
                    ),
                    heroTag: null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
