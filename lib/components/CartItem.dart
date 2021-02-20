import 'package:flutter/material.dart';

import 'CartView.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    this.quantity,
    this.price,
    this.name,
    this.hasMod,
    this.editPressed,
    this.removePressed,
    this.isSelected,
    this.duplicatePressed,
  }) : super(key: key);
  final int quantity;
  final double price;
  final String name;
  final bool hasMod;
  final Function editPressed;
  final Function removePressed;
  final Function duplicatePressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: editPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Stack(children: [
                      Container(
                        child: Center(
                            child: Text(quantity.toString(),
                                style: TextStyle(color: Colors.white))),
                        height: 31,
                        width: 31,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Positioned(
                          left: 4,
                          top: 4,
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeOutQuad,
                              opacity: isSelected ? 1 : 0,
                              child: Container(
                                  child: Center(
                                      child: Text(quantity.toString(),
                                          style:
                                          TextStyle(color: Colors.white))),
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        Colors.deepPurple.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(100),
                                  )))),
                      ModNotification(hasMod: hasMod)
                    ]),
                  ),
                  Container(
                    width: 20,
                  ),
                  Text(name, style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(children: [
                Text("€" + price.toStringAsFixed(2),
                    style: TextStyle(color: Colors.grey)),
              ]),
              Container(width: 20),
              /*SizedBox(
                  width: 25,
                  height: 25,
                  child: ShowEditViewButton(editPressed: editPressed)),*/
              Container(width: 10),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                    width: 25,
                    height: 25,
                    child: FloatingActionButton(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.asset("images/copy.png"),
                        ),
                        onPressed: duplicatePressed,
                        heroTag: null,
                        backgroundColor: Colors.blue)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                    width: 25,
                    height: 25,
                    child: FloatingActionButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("images/close.png"),
                        ),
                        onPressed: removePressed,
                        heroTag: null,
                        backgroundColor: Colors.redAccent)),
              ),
            ],
          )
        ],
      ),
    );
  }
}