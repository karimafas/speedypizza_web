import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/globals/menu.dart';
import 'package:speedypizza_web/provider/state_infos.dart';

int selectedIndex = 0;

class MenuView extends StatelessWidget {
  const MenuView({
    Key key, this.numberController, this.quantityController, this.viewController, this.pressed, this.modController,
  }) : super(key: key);
  final TextEditingController numberController;
  final TextEditingController modController;
  final TextEditingController quantityController;
  final PageController viewController;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: PageView(
          controller: viewController,
          children: [
            MenuPage(start: 0, end: 63, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 63, end: 74, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 164, end: 171, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 126, end: 142, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 142, end: 163, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 114, end: 126, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 74, end: 114, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.allItems, pressed: pressed, isMod: false),
            MenuPage(start: 0, end: 166, numberController: numberController, modController: modController, quantityController: quantityController, list: SpeedyMenu.fullVariations, pressed: pressed, isMod: true),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({
    Key key,
    this.start,
    this.end, this.numberController, this.quantityController, this.list, this.pressed, this.isMod, this.modController, this.node,
  }) : super(key: key);
  final int end;
  final int start;
  final TextEditingController numberController;
  final TextEditingController quantityController;
  final TextEditingController modController;
  final List list;
  final Function pressed;
  final bool isMod;
  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scrollbar(
          child: ListView.separated(
              separatorBuilder: (context, index) => Container(
                height: 20,
                color: Colors.transparent,
              ),
              itemCount: end - start,
              itemBuilder: (context, index) {
                return MenuListItem(
                  number: list[index + start][0],
                  name: list[index + start][1],
                  description: list[index + start][2],
                  price: double.parse(list[index + start][3]).toStringAsFixed(2),
                  pressed: () {
                    if(!isMod) {
                      Provider.of<OrderContainerInfo>(context, listen: false)
                          .clearMods();
                      if (list[index + start][4] != false) {
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .expand();
                      } else {
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .shrink();
                      }
                      numberController.text = list[index + start][0];
                      numberController.selection = TextSelection.fromPosition(
                          TextPosition(offset: numberController.text.length));
                      quantityController.selection = TextSelection.fromPosition(
                          TextPosition(offset: quantityController.text.length));
                      quantityController.text = "1";
                    }
                    else {
                      modController.selection = TextSelection.fromPosition(
                          TextPosition(offset: modController.text.length));
                      Provider.of<OrderContainerInfo>(context, listen: false).updateSelectedModCode(list[index + start][0]);
                      if(Provider.of<OrderContainerInfo>(context, listen: false).isModifying) {
                        modController.text = list[index + start][0];
                        Provider.of<OrderContainerInfo>(context,
                            listen: false)
                            .addCurrentMod(modController.text);
                        modController.text = "";
                      }
                    }

                    pressed(list[index + start][1], list[index + start][3], isMod, list[index + start][5]);
                  },
                );
              }),
        ));
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    Key key,
    this.number,
    this.name,
    this.description,
    this.price,
    this.pressed,
  }) : super(key: key);
  final String number;
  final String name;
  final String description;
  final String price;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //splashColor: Colors.transparent,
      onTap: pressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                    child: Text(number, style: TextStyle(color: Colors.white))),
              ),
              Container(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text(description != "" ? description + "." : "",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.5), fontSize: 14)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text("€$price",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.5), fontSize: 16)),
              Container(width: 25),
            ],
          ),
        ],
      ),
    );
  }
}