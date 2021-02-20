import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class speedyField extends StatelessWidget {
  const speedyField({
    Key key, this.width, this.submitted, this.controller,
  }) : super(key: key);
  final double width;
  final Function submitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autofocus: true,
          controller: controller,
          onSubmitted: submitted,
          cursorColor: Colors.deepPurple,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      height:  50,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
