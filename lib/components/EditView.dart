import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/screens/ReviewScreen.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:speedypizza_web/components/SpeedySeparator.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:transparent_image/transparent_image.dart';

FocusNode focus = new FocusNode();
TextEditingController modController = new TextEditingController();

class EditView extends StatefulWidget {
  const EditView({
    Key key,
    this.pressed,
  }) : super(key: key);
  final Function pressed;

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  Widget build(BuildContext context) {

    return Consumer<Cart>(builder: (context, data, index) {
      return AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuad,
        opacity: data.cart.length > 0 ? 1 : 0,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(data.cart.length != 0 ? data.cart[selectedItemIndex][0][0] : "",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          Container(height: 10),
          SpeedySeparator(width: 100),
          Container(height: 10),
          Text(
              data.cart.length != 0
                  ? "€" + double.parse(data.cart[selectedItemIndex][0][1]).toStringAsFixed(2)
                  : "",
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          Container(height: 20),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            height: data.modsContainerHeight,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FadeIn(
                    0.5, Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150),
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeMod(index, selectedItemIndex);
                        },
                        child: Text(data.selectedModsList[index][0],
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 5);
                },
                itemCount:
                data.selectedModsList.length),
          ),
          Container(height: 10),
          AnimatedOpacity(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOutQuad,
            opacity: data.isAddingMod ? 1 : 0,
            child: AnimatedContainer(
                color: Colors.transparent,
                duration: Duration(milliseconds: 600),
                curve: Curves.easeOutQuad,
                width: 150,
                height: data.varContainerHeight,
                child: TextFormField(
                  focusNode: focus,
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    if(!data.isAddingMod) {
                      Provider.of<Cart>(context, listen: false).setIsAddingVar(
                          true);
                      Provider.of<Cart>(context, listen: false).showVarContainer();
                      modController.text = "";
                      focus.requestFocus();
                    }
                    else {
                      Provider.of<Cart>(context, listen: false)
                          .addCurrentMod(modController.text, selectedItemIndex);
                      modController.text = "";
                      focus.requestFocus();
                    }
                  },
                  controller: modController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Variazione",
                  ),
                )),
          ),
          Container(height: 20),
          AnimatedContainer(
            height: data.varButtonHeight,
            width: data.varButtonHeight,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutQuad,
            child: FloatingActionButton(
              tooltip: "Aggiungi una variazione",
              onPressed: () {
                if(!data.isAddingMod) {
                  Provider.of<Cart>(context, listen: false).setIsAddingVar(
                      true);
                  Provider.of<Cart>(context, listen: false).showVarContainer();
                  modController.text = "";
                  focus.requestFocus();
                }
                else {
                  Provider.of<Cart>(context, listen: false)
                      .addCurrentMod(modController.text, selectedItemIndex);
                  modController.text = "";
                  focus.requestFocus();
                }
              },
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: data.variationsButtonColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                duration: Duration(milliseconds: 250),
                curve: Curves.easeOutQuad,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutQuad,
                  padding: EdgeInsets.all(data.varButtonPadding),
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "https://i.ibb.co/XSGN01y/variations.png"),
                ),
              ),
            ),
          )
        ]),
      );
    });
  }
}
