import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/CartView.dart';
import 'package:speedypizza_web/components/EditView.dart';
import 'package:speedypizza_web/components/TimeAndDetails.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import '../provider/cart.dart';
import '../navigation/routing_constants.dart';

int selectedItemIndex = 0;

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<Cart>(context, listen: false).switchHasSelected(true);
    });

    return GestureDetector(
      onTap: () {
        Provider.of<Cart>(context, listen: false).setIsAddingVar(false);
        Provider.of<Cart>(context, listen: false).showVarContainer();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(title: Text(!Provider.of<Cart>(context, listen: false).isReopeningOrder ? "Rivedi – Ordine #" + globals.orderNumber.toString() : "Rivedi – Ordine #" + globals.reopenedOrderNumber.toString()), leading: BackButton(
          onPressed: () {
            if(Provider.of<Cart>(context, listen: false).isReopeningOrder) {
              Navigator.pushReplacementNamed(context, OrderScreenRoute);
            }
            else {
              Navigator.pop(context);
            }
          },
        )),
        body: SingleChildScrollView(child: ReviewBody()),
      ),
    );
  }
}

class ReviewBody extends StatefulWidget {
  const ReviewBody({
    Key key,
  }) : super(key: key);

  @override
  _ReviewBodyState createState() => _ReviewBodyState();
}

class _ReviewBodyState extends State<ReviewBody> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SlideYFadeIn(0.5, TimeAndDetails()), flex: 2),
        Container(
          width: 3,
          color: Colors.grey.withOpacity(.2),
          height: 600,
        ),
        Expanded(child: SlideYFadeIn(1.5, CartView()), flex: 3),
        Container(
          width: 3,
          color: Colors.grey.withOpacity(.2),
          height: 600,
        ),
        Expanded(child: SlideYFadeIn(2.5, EditView()), flex: 2),
      ],
    );
  }
}
