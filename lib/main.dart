import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/archive.dart';
import 'package:speedypizza_web/screens/AnalyticsScreen.dart';
import 'package:speedypizza_web/screens/HomeScreen.dart';
import 'provider/cart.dart';
import 'navigation/router.dart' as router;

void main() {
  runApp(ChangeNotifierProvider(create: (context) => Cart(), child: App()));
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => Archive()),
                //ChangeNotifierProvider(create: (context) => CustomersInfo()),
              ],
            child: SizedBox(
              height: 200,
              width: 200,
              child: MaterialApp(
                builder: (BuildContext context, Widget child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child,
                  );
                },
                title: 'Speedy Pizza Web',
                onGenerateRoute: router.generateRoute,
                theme: ThemeData(
                  fontFamily: 'Proxima Nova',
                  primarySwatch: Colors.deepPurple,
                  inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                home: HomeScreen(),
                debugShowCheckedModeBanner: false,
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
