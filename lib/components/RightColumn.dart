import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/archive.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/screens/ArchiveScreen.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

class RightColumn extends StatelessWidget {
  const RightColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 40),
        child: Stack(children: [CartButton(), CartNotification()]),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        if (Provider.of<Cart>(context, listen: false).cart.length > 0) {
          if (!globals.hasOpenedFirstOrder) {
            runOneByOne<void>([
              () => setHasChanges(context, true),
              () =>
                  Provider.of<Archive>(context, listen: false).initialiseDate(),
              () => print(
                  Provider.of<Archive>(context, listen: false).dtSelectedDate),
              () => fetchOrderData(context),
              () => globals.hasOpenedFirstOrder = true,
              () => globals.todaysList =
                  Provider.of<Archive>(context, listen: false).ordersList,
              () => Navigator.pushNamed(context, ReviewScreenRoute),
            ]);
          } else {
            runOneByOne<void>([
              () => fetchOrderData(context),
              () => Provider.of<Cart>(context, listen: false).isReopeningOrder
                  ? Navigator.pushReplacementNamed(context, ReviewScreenRoute)
                  : Navigator.pushNamed(context, ReviewScreenRoute),
            ]);
          }
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text('Errore'),
                    content: Text('Aggiungi un prodotto al carrello.'),
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
        padding: const EdgeInsets.all(18.0),
        child: Image.asset("images/cart.png"),
      ),
    );
  }
}

class CartNotification extends StatelessWidget {
  const CartNotification({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(child: Consumer<Cart>(builder: (context, data, info) {
      return AnimatedOpacity(
        opacity: data.cart.isEmpty ? 0 : 1,
        duration: Duration(milliseconds: 600),
        child: Container(
          width: data.cart.isEmpty ? 0 : 22,
          height: data.cart.isEmpty ? 0 : 22,
          child: Center(
              child: Text(data.cart.length.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600))),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 15,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    }));
  }
}
