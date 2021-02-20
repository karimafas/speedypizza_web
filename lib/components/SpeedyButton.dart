import 'package:flutter/material.dart';

class speedyButton extends StatelessWidget {
  const speedyButton({
    Key key, this.text, this.color, this.pressed, this.width,
  }) : super(key: key);
  final String text;
  final Color color;
  final Function pressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
          child: Text(text, style: TextStyle(color: color, fontSize: 17)),
          onPressed: pressed,
        ),
      ),
    );


    /*return InkWell(
      child: Container(
        child: Center(child: Text(text, style: TextStyle(color: color, fontSize: 17))),
        height:  50,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
      ),
      onTap: pressed,
    );*/
  }
}