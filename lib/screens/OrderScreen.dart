import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/provider/state_infos.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/CenterColumn.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:speedypizza_web/components/LeftColumn.dart';
import 'package:speedypizza_web/components/RightColumn.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

int currentPage = 0;
PageController viewController = new PageController(initialPage: currentPage);
TextEditingController numberController = new TextEditingController();
TextEditingController quantityController = new TextEditingController();
TextEditingController modController = new TextEditingController();
List<String> currentMods = [];
String itemName = "";
String itemPrice = "0";

class OrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(!Provider.of<Cart>(context, listen: false).isReopeningOrder ? "Ordine #" + globals.orderNumber.toString() : "Ordine #" + globals.reopenedOrderNumber.toString()),
      ),
      body: ChangeNotifierProvider(child: OrderBody(), create: (context) => OrderContainerInfo()),
    );
  }
}

class OrderBody extends StatefulWidget {
  const OrderBody({
    Key key,
  }) : super(key: key);

  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {

  @override
  Widget build(BuildContext context) {

    FocusNode focus = new FocusNode();

    return Stack(alignment: Alignment.bottomCenter, children: [
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container(), flex: 1),
              Expanded(child: SlideYFadeIn(0.5, LeftColumn(focus: focus)), flex: 3),
              Expanded(child: Container(), flex: 1),
              Expanded(child: SlideYFadeIn(1.5, CenterColumn()), flex: 13),
              Expanded(child: SlideYFadeIn(2.5, RightColumn()), flex: 2),
            ],
          ),
        ]),
      ),
    ]);
  }
}

