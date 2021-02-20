import 'package:flutter/material.dart';

class CustomerDetails extends ChangeNotifier {
  //String _name;
  String _surname;
  String _phone;
  String _address;
  String _doorno;
  String _floor;
  String _discount;
  String _credit;

  //String get name => _name;
  String get surname => _surname;
  String get phone => _phone;
  String get address => _address;
  String get doorno =>_doorno;
  String get floor => _floor;
  String get discount => _discount;
  String get credit => _credit;
}