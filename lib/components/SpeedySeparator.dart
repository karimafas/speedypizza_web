import 'package:flutter/material.dart';

class SpeedySeparator extends StatelessWidget {
  const SpeedySeparator({
    Key key, this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: 4,
        decoration: BoxDecoration(color: Colors.deepPurple, boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 20,
            offset: Offset(0, -10), // changes position of shadow
          ),
        ]));
  }
}