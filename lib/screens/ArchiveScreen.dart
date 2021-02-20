import 'dart:convert';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/components/SingleOrder.dart';
import 'package:speedypizza_web/provider/archive.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/DatePicker.dart';
import 'package:speedypizza_web/components/OrderTracker.dart';
import 'package:speedypizza_web/components/StatsBox.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:speedypizza_web/components/SideMenu.dart';
import 'package:intl/intl.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;
import '../provider/cart.dart';
import 'DetailsScreen.dart';

Future<void> deleteOrderFromDatabase(int index, BuildContext context, String date) async {
  var result = await FirebaseFirestore.instance
      .collection("orders")
      .where("datePlaced",
      isEqualTo: date)
      .where("timePlaced", isEqualTo: Provider.of<Archive>(context, listen: false).ordersList[index][0])
      .get();

  result.docs.forEach((element) {
    element.reference.delete();
  });
}

class ArchiveScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(selectedIndex: 1),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Archivio ordini"),
      ),
      body: ArchiveBody(),
    );
  }
}

DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
String timeToShow;

Future<void> setHasChanges(BuildContext context, bool value) async {
  await FirebaseFirestore.instance
      .collection("archive")
      .doc(_dateFormat
          .format(Provider.of<Archive>(context, listen: false).dtSelectedDate))
      .set({"hasChanges": value});
}

Future<void> fetchOrderData(BuildContext context) async {
  FirebaseFirestore.instance
      .collection('archive')
      .doc(_dateFormat
          .format(Provider.of<Archive>(context, listen: false).dtSelectedDate))
      .get()
      .then((value) async {
    if (value.data()["hasChanges"]) {
      Provider.of<Archive>(context, listen: false).clear();
      print("Reading from database.");

      var result = await FirebaseFirestore.instance
          .collection("orders")
          .where("datePlaced",
              isEqualTo: _dateFormat.format(
                  Provider.of<Archive>(context, listen: false).dtSelectedDate))
          .get();
      result.docs.forEach((result) {
        if (result.data()["order"] != null) {
          Provider.of<Archive>(context, listen: false).add(
            result.data()["timePlaced"],
            result.data()["deliveryTime"],
            result.data()["phone"].toString(),
            result.data()["nameSurname"].toString(),
            result.data()["order"].toString(),
            result.data()["total"].toString(),
            result.data()["notes"].toString(),
            result.data()["cash"],
            result.data()["wasEdited"],
            result.data()["datePlaced"],
            result.data()["pony"],
            result.data()["timeDelivered"],
            result.data()["orderNumber"],
          );
        }
      });

      setHasChanges(context, false);
    }
    Provider.of<Archive>(context, listen: false).clearSortedTimes();
    Provider.of<Archive>(context, listen: false).getOrderTimes();
    Provider.of<Archive>(context, listen: false).getDeliveryTimes();
  });
}

fetchCustomerData(BuildContext context, int index, List list) async {
  var customerResult = await FirebaseFirestore.instance
      .collection("customers")
      .where("phone",
          isEqualTo:
              list[index][2])
      .get();

  customerResult.docs.forEach((customerResult) {
    if (customerResult.data()["surname"] != null) {
      globals.surname = customerResult.data()["surname"].toString().inCaps;
      globals.phone = customerResult.data()["phone"];
      globals.address = customerResult.data()["address"].toString();
      globals.doorno = customerResult.data()["doorno"].toString();
      globals.floor = customerResult.data()["floor"].toString();
      globals.credit = customerResult.data()["credit"].toString();
      globals.discount = customerResult.data()["discount"].toString();
      globals.area = customerResult.data()["area"].toString();
    }
  });
}

Future<List<T>> runOneByOne<T>(List<T Function()> list) {
  if (list.isEmpty) {
    return Future.value(null);
  }
  Future task = Future<T>.microtask(list.first);
  final List<T> results = [];

  for (var i = 1; i < list.length; i++) {
    final func = list[i];
    task = task.then((res) {
      results.add(res);
      return Future<T>.microtask(func);
    });
  }

  return task.then((res) {
    results.add(res);
    return results;
  });
}

class ArchiveBody extends StatefulWidget {
  const ArchiveBody({
    Key key,
  }) : super(key: key);

  @override
  _ArchiveBodyState createState() => _ArchiveBodyState();
}

class _ArchiveBodyState extends State<ArchiveBody> {
  @override
  void initState() {
    if (!globals.hasOpenedFirstOrder) {
      runOneByOne<void>([
        () => setHasChanges(context, true),
        () => fetchOrderData(context),
        () => Provider.of<Archive>(context, listen: false).initialiseDate(),
        () => globals.todaysList =
            Provider.of<Archive>(context, listen: false).ordersList,
      ]);
      globals.hasOpenedFirstOrder = true;
    } else {
      runOneByOne<void>([
        () => fetchOrderData(context),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(window.outerWidth);
    return Consumer<Archive>(builder: (context, data, index) {
      return Row(
        children: [
          Expanded(
              child: Transform.scale(
                scale: .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: DatePicker(),
                    ),
                    InkWell(
                      key: data.statsKey,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        if (data.dinner) {
                          data.switchDinner(false);
                        } else {
                          data.switchDinner(true);
                        }
                        data.updateKey();
                        data.clearSortedTimes();
                        data.getOrderTimes();
                        data.switchOrdersShown(data.dinner);
                      },
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeOutQuad,
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: data.dinner ? darkGrey : Colors.black26,
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AnimatedSwitcher(
                              switchOutCurve: Curves.easeOutQuad,
                              switchInCurve: Curves.easeInQuad,
                              transitionBuilder: (widget, animation) =>
                                  FadeTransition(
                                opacity: animation,
                                child: RotationTransition(
                                  turns: animation,
                                  child: widget,
                                ),
                              ),
                              duration: const Duration(milliseconds: 1000),
                              child: data.imageShown,
                            ),
                          ))),
                    ),
                    OrderTracker(),
                    Container(height: 30),
                  ],
                ),
              ),
              flex: 3),
          Expanded(child: OrdersView(), flex: 6),
          Expanded(child: Container(), flex: 1),
        ],
      );
    });
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double delay = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container(), flex: 1),
        Expanded(
          flex: 6,
          child: SlideFadeInRTL(
            1,
            Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: darkGrey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 60, right: 60, bottom: 40),
                  child: Consumer<Archive>(builder: (context, data, index) {
                    return GridView.count(
                        crossAxisCount: 6,
                        childAspectRatio: 5 / 5,
                        children:
                            List.generate(data.ordersList.length, (index) {
                          if (index != 0) {
                            delay += 0.1;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SlideYFadeIn(
                                delay,
                                SingleOrder(
                                    deleteOrder: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text('Vuoi continuare?'),
                                              content: Text(
                                                  "L'eliminazione è irreversibile.\nDesideri procedere?"),
                                              actions: [
                                                ElevatedButton(
                                                    child: Text("Annulla"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }),
                                                ElevatedButton(
                                                    child: Text("Elimina"),
                                                    onPressed: () {
                                                      runOneByOne<void>([
                                                            () => deleteOrderFromDatabase(index, context, data.ordersList[index][9]),
                                                            () => data.removeOrder(index),
                                                            () => Navigator.pop(context)
                                                      ]);

                                                      final snackBar = SnackBar(
                                                        content: Text('Ordine eliminato con successo.'),
                                                      );
                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    }),
                                              ],
                                            );
                                          });
                                    },
                                    timePlaced: data.ordersList[index][0],
                                    deliveryTime: data.ordersList[index][1],
                                    phone: data.ordersList[index][2],
                                    nameSurname: data.ordersList[index][3],
                                    total:
                                        double.parse(data.ordersList[index][5])
                                            .toStringAsFixed(2),
                                    productsNumber:
                                        data.ordersList.length.toString(),
                                    isCash: data.ordersList[index][7],
                                    wasEdited: data.ordersList[index][8],
                                    pony: data.ordersList[index][10],
                                    hasLeft: data.ordersList[index][11] == ""
                                        ? false
                                        : true,
                                    leftTime: data.ordersList[index][11],
                                    pressed: () {
                                      if (data.ordersList[index][10] != "") {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Text(
                                                      'Ordine in consegna!'),
                                                  content: Text(
                                                      "Questo ordine è partito per la consegna alle " +
                                                          data.ordersList[index]
                                                              [11] +
                                                          "." +
                                                          "\nSei sicuro di voler continuare?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        child: Text("Annulla"),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context)),
                                                    ElevatedButton(
                                                      child: Text("Continua"),
                                                      onPressed: () {
                                                        globals.notes = data.ordersList[
                                                        index][6];

                                                        globals.reopenedOrderNumber =
                                                            data.ordersList[
                                                                index][12];

                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .reopenCart(json.decode(
                                                                data.ordersList[
                                                                    index][4]));

                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .getModsList(0);

                                                        globals.timePlaced =
                                                            data.ordersList[
                                                                index][0];
                                                        globals.datePlaced =
                                                            data.ordersList[
                                                                index][9];

                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .switchIsReopeningOrder(
                                                                true);

                                                        String sTime =
                                                            data.ordersList[
                                                                index][1];
                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .setTime(TimeOfDay(
                                                                hour: int.parse(
                                                                    sTime.split(
                                                                            ":")[
                                                                        0]),
                                                                minute: int.parse(
                                                                    sTime.split(
                                                                            ":")[
                                                                        1])));
                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .switchHasChosenTime(
                                                                true);

                                                        bool isCash =
                                                            data.ordersList[
                                                                index][7];
                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .setCashCardSelection(
                                                                isCash ? 0 : 1);

                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .setNotes(
                                                                data.ordersList[
                                                                    index][6]);

                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .setTotal(double.parse(
                                                                data.ordersList[
                                                                    index][5]));

                                                        runOneByOne<void>([
                                                          () =>
                                                              fetchCustomerData(
                                                                  context,
                                                                  index, data.ordersList),
                                                          () => Navigator.pop(
                                                              context),
                                                          () => Navigator.pushNamed(
                                                              context,
                                                              ReviewScreenRoute),
                                                        ]);
                                                      },
                                                    ),
                                                  ],
                                                ));
                                      } else {
                                        globals.reopenedOrderNumber =
                                            data.ordersList[index][12];

                                        globals.notes = data.ordersList[
                                        index][6];

                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .reopenCart(json.decode(
                                                data.ordersList[index][4]));

                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .getModsList(0);

                                        globals.timePlaced =
                                            data.ordersList[index][0];
                                        globals.datePlaced =
                                            data.ordersList[index][9];

                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .switchIsReopeningOrder(true);

                                        String sTime =
                                            data.ordersList[index][1];
                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .setTime(TimeOfDay(
                                                hour: int.parse(
                                                    sTime.split(":")[0]),
                                                minute: int.parse(
                                                    sTime.split(":")[1])));
                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .switchHasChosenTime(true);

                                        bool isCash = data.ordersList[index][7];
                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .setCashCardSelection(
                                                isCash ? 0 : 1);

                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .setNotes(
                                                data.ordersList[index][6]);

                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .setTotal(double.parse(
                                                data.ordersList[index][5]));

                                        runOneByOne<void>([
                                          () =>
                                              fetchCustomerData(context, index, data.ordersList),
                                          () => Navigator.pushNamed(
                                              context, ReviewScreenRoute),
                                        ]);
                                      }
                                    })),
                          );
                        }));
                  }),
                )),
          ),
        ),
        Expanded(
            child: Consumer<Archive>(builder: (context, data, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatsBox2(
                    delay: 1,
                    stat1Key: "Numero ordini:",
                    stat2Key: "Spesa media:",
                    stat1Value: data.ordersList.length.toString(),
                    stat2Value: "€" + data.averageOrderSpend.toStringAsFixed(2),
                    imageUrl: "https://i.imgur.com/VW47Yp4.png",
                    statsKey: data.statsKey,
                  ),
                ],
              );
            }),
            flex: 3)
      ],
    );
  }
}
