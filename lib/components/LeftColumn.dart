import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/screens/OrderScreen.dart';
import 'package:speedypizza_web/components/OrderTab.dart';
import 'package:speedypizza_web/components/RecapView.dart';
import 'package:speedypizza_web/provider/state_infos.dart';

class LeftColumn extends StatelessWidget {
  const LeftColumn({
    Key key,
    @required this.focus,
  }) : super(key: key);

  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Consumer<OrderContainerInfo>(
          builder: (context, data, index) {
            return Column(
              children: [
                Container(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeOutQuad,
                  height: data.hasClicked ? 120 : 0,
                  child: SingleChildScrollView(
                    child: AnimatedOpacity(
                        opacity: data.hasClicked ? 1 : 0,
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeOutQuad,
                        child: RecapView()),
                  ),
                ),
                OrderTab(
                    pressed: () {
                      String mods = json.encode(Provider.of<OrderContainerInfo>(
                          context,
                          listen: false)
                          .currentMods);

                      for(int i = 0; i < int.parse(quantityController.text); i++) {
                        Provider.of<Cart>(context, listen: false)
                            .addItem(data.itemName, data.itemPrice.toStringAsFixed(2), mods, data.itemType);
                      }

                      Provider.of<OrderContainerInfo>(context,
                          listen: false)
                          .switchClicked(false);

                      Provider.of<OrderContainerInfo>(context,
                          listen: false)
                          .shrink();
                      quantityController.text = "";
                      numberController.text = "";

                      //Provider.of<Cart>(context, listen: false).cart.sort();
                    },
                    focus: focus,
                    modController: modController,
                    numberController: numberController,
                    quantityController: quantityController,
                    itemName: itemName),
              ],
            );
          }
      ),
    );
  }
}
