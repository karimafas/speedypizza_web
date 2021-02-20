//
// Generated file. Do not edit.
//

import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:printing/src/printing_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FirebaseFirestoreWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  GoogleMapsPlugin.registerWith(registrar);
  PrintingPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
