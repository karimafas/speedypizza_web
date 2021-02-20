import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/screens/OrderScreen.dart';
import 'package:speedypizza_web/provider/state_infos.dart';
import 'package:speedypizza_web/components/CategoriesBar.dart';
import 'package:speedypizza_web/components/MenuView.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

class CenterColumn extends StatelessWidget {
  const CenterColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: CategoriesBar(viewController: viewController),
        ),
        MenuView(
          pressed: (name, price, isMod, type) {
            if (!isMod) {
              itemName = name;
              itemPrice = price;
              Provider.of<OrderContainerInfo>(context,
                  listen: false)
                  .setName(name);
              Provider.of<OrderContainerInfo>(context,
                  listen: false)
                  .getPrice(price);
              Provider.of<OrderContainerInfo>(context,
                  listen: false)
                  .setType(type);
              Provider.of<OrderContainerInfo>(context,
                  listen: false)
                  .switchClicked(true);
            }
          },
          numberController: numberController,
          quantityController: quantityController,
          viewController: viewController,
          modController: modController,
        ),
        Column(
          children: [
            Text(globals.surname,
                style:
                TextStyle(color: Colors.white, fontSize: 16)),
            Container(height: 4),
            Text(globals.phone,
                style:
                TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        Container(height: 7),
        Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 15,
                  offset:
                  Offset(0, 5), // changes position of shadow
                ),
              ],
              color: Colors.deepPurple,
            )),
        Container(height: 7),
        Text(globals.address + ", " + globals.doorno,
            style:
            TextStyle(color: Colors.grey, fontSize: 12)),
        Container(height: 500),
      ],
    );
  }
}

