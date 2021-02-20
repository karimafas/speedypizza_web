import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/screens/ReviewScreen.dart';
import 'package:speedypizza_web/components/CartItem.dart';
import 'package:speedypizza_web/components/FadeIn.dart';

class CartListView extends StatefulWidget {
  const CartListView({
    Key key,
  }) : super(key: key);

  @override
  _CartListViewState createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<Cart>(context, listen: false).getModsList(0);
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 300,
      child: Scrollbar(
        child: Consumer<Cart>(
          builder: (context, data, index) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Container(height: 10);
              },
              itemCount: data.cart.length,
              itemBuilder: (context, index) {
                return SlideFadeIn(
                  0.3,
                  CartItem(
                    name: data.cart[index][0][0],
                    quantity: data.cart[index][1][0],
                    price: double.parse(data.cart[index][0][1]),
                    isSelected: selectedItemIndex == index ? true : false,
                    hasMod: data.cart[index][0][2] != "[]" ? true : false,
                    editPressed: () {
                      selectedItemIndex = index;

                      Provider.of<Cart>(context, listen: false)
                          .setIsAddingVar(false);
                      Provider.of<Cart>(context, listen: false)
                          .showVarContainer();

                      Provider.of<Cart>(context, listen: false)
                          .switchHasSelected(true);

                      Provider.of<Cart>(context, listen: false)
                          .switchItemDetails(
                          data.cart[index][0][0],
                          data.cart[index][0][1],
                          data.cart[index][0][2]);

                      data.getModsList(index);
                    },
                    duplicatePressed: () {
                      data.addItem(data.cart[index][0][0],
                          data.cart[index][0][1], data.cart[index][0][2], data.cart[index][0][3]);
                    },
                    removePressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .removeItem(index);
                      if (data.cart.length == 0) {
                        Provider.of<Cart>(context, listen: false)
                            .switchHasSelected(false);
                      } else {
                        Provider.of<Cart>(context, listen: false)
                            .switchHasSelected(true);
                      }

                      if (index == data.cart.length) {
                        if (index == 1) {
                          selectedItemIndex = index - 1;
                        } else {
                          selectedItemIndex = 0;
                        }
                      } else {
                        selectedItemIndex = index;
                      }
                    },
                  ),
                );
              },
              shrinkWrap: true,
            );
          }
        ),
      ),
    );
  }
}