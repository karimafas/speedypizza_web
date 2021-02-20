import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../globals/menu.dart';

class OrderContainerInfo extends ChangeNotifier {
  double _containerHeight = 220;
  double _listHeight = 10;
  double _buttonSpace = 40;
  bool _isModifying = false;
  List _currentMods = [];
  String _recapMods = "";
  double _itemPrice = 0;
  String _itemName = "";
  String _itemType = "";
  bool _hasClicked = false;
  String _selectedModCode = "";

  void switchClicked(bool value) {
    _hasClicked = value;
    notifyListeners();
  }

  void updateSelectedModCode(String code) {
    _selectedModCode = code;
  }

  void setName(String name) {
    _itemName = name;
    notifyListeners();
  }

  void setType(String type) {
    _itemType = type;
    print(_itemType);
    notifyListeners();
  }

  void setPrice(double price) {
    _itemPrice = price;
    notifyListeners();
  }

  void getPrice(String price) {
    _itemPrice = double.parse(price);
    notifyListeners();
  }

  void expand() {
    _containerHeight = 300;
    _buttonSpace = 120;
    _isModifying = true;
    notifyListeners();
  }

  void shrink() {
    _containerHeight = 220;
    _buttonSpace = 40;
    _isModifying = false;
    notifyListeners();
  }

  void clearMods() {
    _currentMods.clear();
    _listHeight = 0;
    notifyListeners();
  }

  void updateModsString() {
    _recapMods = "";
    for (int i = 0; i < _currentMods.length; i++) {
      _recapMods +=
          (currentMods[i][0]).toString().replaceAll('"', "").toLowerCase() +
              ", ";
    }

    _recapMods = _recapMods.substring(0, _recapMods.length - 2);
    _recapMods += ".";
    _recapMods = _recapMods[0].toUpperCase() + _recapMods.substring(1);
  }

  void addCurrentMod(String query) {
    List<String> abbreviations = SpeedyMenu().getVariationAbbreviations();
    int index = abbreviations.indexOf(query.toUpperCase());

    _currentMods.add([
      SpeedyMenu.fullVariations[index][1],
      SpeedyMenu.fullVariations[index][3]
    ]);
    updateModsString();
    updatePrice(_itemPrice, true, double.parse(SpeedyMenu.fullVariations[index][3]));

    //updates interface
    if (_currentMods.length < 5) {
      _containerHeight += 33;
      _buttonSpace += 33;
      _listHeight += 33;
    }

    notifyListeners();
  }

  void removeMod(int index) {
    updatePrice(_itemPrice, false, double.parse(_currentMods[index][1]));
    _currentMods.removeAt(index);

    if (_currentMods.isNotEmpty) {
      updateModsString();
    }
    else {
      _recapMods = "";
    }

    //updates interface
    if (_currentMods.length < 4) {
      _containerHeight -= 33;
      _buttonSpace -= 33;
      _listHeight -= 33;
    }

    notifyListeners();
  }

  void updatePrice(double initialPrice, bool isAdding, double modPrice) {
    if (isAdding) {
      _itemPrice += modPrice;
    }
    else {
      _itemPrice -= modPrice;
    }
  notifyListeners();
}

String get selectedModCode => _selectedModCode;

bool get hasClicked => _hasClicked;

double get itemPrice => _itemPrice;

String get itemName => _itemName;

String get itemType => _itemType;

String get recapMods => _recapMods;

double get listHeight => _listHeight;

List get currentMods => _currentMods;

bool get isModifying => _isModifying;

double get containerHeight => _containerHeight;

double get buttonSpace => _buttonSpace;}
