import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/AnalyticsBody.dart';
import 'package:speedypizza_web/components/SideMenu.dart';

import '../provider/analytics.dart';

List categories = [
  ["Pizze", 0.2, Colors.green],
  ["Covaccini", 0.25, Colors.green],
  ["Kebab", 0.9, Colors.green],
];

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideMenu(selectedIndex: 2),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Statistiche"),
      ),
      body: ChangeNotifierProvider(
          child: AnalyticsBody(size: size), create: (context) => Analytics()),
    );
  }
}