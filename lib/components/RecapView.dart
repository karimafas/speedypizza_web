import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/state_infos.dart';

class RecapView extends StatelessWidget {
  const RecapView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Consumer<OrderContainerInfo>(
        builder: (context, data, index) {
          return Column(
            children: [
              Text(data.itemName, style: TextStyle(color: Colors.white, fontSize: 18)),
              Container(height: 8),
              Container(height: 3, width: 100, decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(.6),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                    offset: Offset(0, -7), // changes position of shadow
                  ),
                ],
                color: Colors.deepPurple,
              )),
              Container(height: 8),
              Text("€" + data.itemPrice.toStringAsFixed(2), style: TextStyle(color: Colors.white, fontSize: 16)),
              Container(height: 5),
              AnimatedOpacity(
                opacity: data.currentMods.length == 0 ? 0 : 1,
                duration: Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad,
                  child: Text(data.recapMods, style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center)),
            ],
          );
        }
      ),
    );
  }
}
