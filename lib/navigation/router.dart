import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/customers_info.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/screens/AnalyticsScreen.dart';
import 'package:speedypizza_web/screens/ArchiveScreen.dart';
import 'package:speedypizza_web/screens/CustomersScreen.dart';
import 'package:speedypizza_web/screens/DetailsScreen.dart';
import 'package:speedypizza_web/screens/HomeScreen.dart';
import 'package:speedypizza_web/screens/OrderScreen.dart';
import 'package:speedypizza_web/screens/ReviewScreen.dart';
import 'package:speedypizza_web/screens/RidersScreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  const duration = Duration(milliseconds: 500);

  switch (settings.name) {
    case HomeScreenRoute:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => HomeScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case DetailsScreenRoute:
      var argument = settings.arguments;
      var fromCart = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => DetailsScreen(
          args: argument
        ),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case OrderScreenRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => OrderScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case ReviewScreenRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => ReviewScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case ArchiveScreenRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => ArchiveScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case AnalyticsScreenRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => AnalyticsScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case SpeedyPonyRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => SpeedyPony(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );

    case CustomersRoute:
      var argument = settings.arguments;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => CustomersScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
        transitionDuration: duration,
      );
  }
}
