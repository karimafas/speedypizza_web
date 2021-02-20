import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/globals/menu.dart';
import 'package:speedypizza_web/screens/OrderScreen.dart';
import 'package:speedypizza_web/provider/state_infos.dart';
import 'package:transparent_image/transparent_image.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({
    Key key,
    @required this.focus,
    this.modController,
    this.quantityController,
    this.numberController,
    this.itemName,
    this.pressed,
  }) : super(key: key);

  final FocusNode focus;
  final TextEditingController modController;
  final TextEditingController quantityController;
  final TextEditingController numberController;
  final String itemName;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Consumer<OrderContainerInfo>(
              builder: (context, data, child) {
                return AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeOutQuad,
                    height: data.containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black54,
                    ));
              },
            ),
            Positioned(
                child: OrderMenu(
              pressed: pressed,
              numberController: numberController,
              quantityController: quantityController,
            )),
            Positioned(
                top: 180,
                child: Align(
                  alignment: Alignment.center,
                  child: Consumer<OrderContainerInfo>(
                      builder: (context, data, index) {
                    return Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      visible: data.isModifying,
                      child: AnimatedOpacity(
                        opacity: data.isModifying ? 1 : 0,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeOutQuad,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AddModTextField(
                                    modController: modController,
                                    numberController: numberController,
                                    quantityController: quantityController,
                                    focus: focus,
                                    submitted: (value) {
                                      if (modController.text.isNotEmpty) {
                                        Provider.of<OrderContainerInfo>(context,
                                                listen: false)
                                            .addCurrentMod(modController.text);

                                        modController.text = "";

                                        focus.requestFocus();
                                      }
                                    }),
                                Container(width: 10),
                                AddModButton(pressed: () {
                                  if (modController.text.isNotEmpty) {
                                    Provider.of<OrderContainerInfo>(context,
                                            listen: false)
                                        .addCurrentMod(modController.text);
                                    modController.text = "";
                                  }
                                }),
                              ],
                            ),
                            Container(height: 20),
                            SizedBox(
                              width: 170,
                              height: data.listHeight,
                              child: ListView.separated(
                                  itemCount: data.currentMods.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          data.removeMod(index);
                                        },
                                        child: Text(
                                            data.currentMods[index][0],
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(height: 4);
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ))
          ],
        ),
      ],
    );
  }
}

class AddModTextField extends StatelessWidget {
  const AddModTextField({
    Key key,
    @required this.focus,
    this.submitted,
    this.modController,
    this.quantityController,
    this.numberController,
  }) : super(key: key);
  final Function submitted;
  final TextEditingController modController;
  final TextEditingController quantityController;
  final TextEditingController numberController;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 50,
        child: TextFormField(
          focusNode: focus,
          autofocus: true,
          onFieldSubmitted: submitted,
          controller: modController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Variazioni...",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Codice",
          ),
        ));
  }
}

class AddModButton extends StatelessWidget {
  const AddModButton({
    Key key,
    this.pressed,
  }) : super(key: key);
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 27,
      height: 27,
      child: FloatingActionButton(
        heroTag: null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "https://i.ibb.co/XSGN01y/variations.png"),
        ),
        onPressed: pressed,
      ),
    );
  }
}

class OrderMenu extends StatefulWidget {
  const OrderMenu({
    Key key,
    @required GlobalKey<FormState> formKey,
    this.numberController,
    this.quantityController,
    this.pressed,
  }) : super(key: key);
  final TextEditingController numberController;
  final TextEditingController quantityController;
  final Function pressed;

  @override
  _OrderMenuState createState() => _OrderMenuState();
}

class _OrderMenuState extends State<OrderMenu> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    FocusNode _node1 = new FocusNode();
    FocusNode _node2 = new FocusNode();

    List<String> itemNumbers = [];
    List items = [];

    for (int i = 0; i < SpeedyMenu.allItems.length; i++) {
      itemNumbers.add(SpeedyMenu.allItems[i][0]);
      items.add(SpeedyMenu.allItems[i]);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (int.parse(value) > items.length) {
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .switchClicked(false);
                      } else {
                        quantityController.text = "1";
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .setName(items[int.parse(value) - 1][1]);
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .setPrice(
                                double.parse(items[int.parse(value) - 1][3]));
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .switchClicked(true);
                        Provider.of<OrderContainerInfo>(context, listen: false)
                            .clearMods();

                        if (items[int.parse(value) - 1][4] != false) {
                          Provider.of<OrderContainerInfo>(context,
                                  listen: false)
                              .expand();
                        } else {
                          Provider.of<OrderContainerInfo>(context,
                                  listen: false)
                              .shrink();
                        }
                      }
                    } else {
                      quantityController.text = "";
                      Provider.of<OrderContainerInfo>(context, listen: false)
                          .shrink();
                      Provider.of<OrderContainerInfo>(context, listen: false)
                          .switchClicked(false);
                    }
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: _node1,
                  onEditingComplete: () => _node2.requestFocus(),
                  decoration: InputDecoration(labelText: "Codice"),
                  autofocus: true,
                  controller: widget.numberController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(height: 20),
              SizedBox(
                width: 120,
                child: TextFormField(
                  //textInputAction: TextInputAction.next,
                  focusNode: _node2,
                  decoration: InputDecoration(labelText: "Quantità"),
                  autofocus: true,
                  controller: widget.quantityController,
                  onFieldSubmitted: (value) => widget.pressed(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Consumer<OrderContainerInfo>(builder: (context, data, info) {
                return AnimatedContainer(
                    height: data.buttonSpace,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutQuad);
              }),
              SizedBox(
                width: 45,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      if (numberController.text != "") {
                        if (quantityController.text != "") {
                          widget.pressed();
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Errore'),
                                  content: Text('Aggiungi codice o quantità.'),
                                  actions: [
                                    ElevatedButton(
                                      child: Text("OK"),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "https://i.ibb.co/XSGN01y/variations.png"),
                    )),
              ),
            ],
          )),
    );
  }
}
