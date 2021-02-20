import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/archive.dart';
import 'package:speedypizza_web/screens/ArchiveScreen.dart';

DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

Future<void> _showDatePicker(BuildContext context) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: Provider.of<Archive>(context, listen: false).dtSelectedDate,
    firstDate: DateTime(2015, 1),
    lastDate: DateTime(2100),
  );
  if (picked != null &&
      picked != Provider.of<Archive>(context, listen: false).dtSelectedDate) {
    Provider.of<Archive>(context, listen: false).setDate(picked);
    Provider.of<Archive>(context, listen: false).clear();
    Provider.of<Archive>(context, listen: false).clearSortedTimes();
    runOneByOne<void>([
      () => setHasChanges(context, true),
      () => fetchOrderData(context),
      () => Provider.of<Archive>(context, listen: false).updateStatsKey(),
      () => Provider.of<Archive>(context, listen: false).updateKey(),
      () => Provider.of<Archive>(context, listen: false).switchDinner(false),
    ]);
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key key,
    this.tapped,
  }) : super(key: key);
  final Function tapped;

  @override
  Widget build(BuildContext context) {
    return Consumer<Archive>(builder: (context, data, index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Scegli una data:",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Container(height: 15),
          Container(
            height: 70,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 25,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Center(
                    child: Text(_dateFormat.format(data.dtSelectedDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600))),
                onTap: () async {
                  _showDatePicker(context);
                }),
          ),
        ],
      );
    });
  }
}
