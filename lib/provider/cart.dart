import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:speedypizza_web/globals/menu.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

class Cart extends ChangeNotifier {
  String _selectedItem = "";
  String _selectedPrice = "";
  String _selectedMods = "";
  bool _hasSelected = true;
  List _selectedModsList = [];
  double _total;
  Color _variationsButtonColor = Colors.deepPurple;
  double _varButtonHeight = 40;
  bool _isAddingMod = false;
  double _varContainerHeigth = 0;
  double _varButtonPadding = 10;
  TimeOfDay _deliveryTime = new TimeOfDay.now();
  bool _isHovering = false;
  List _groupedCart = [];
  List _oldCart = [];
  bool _isReopeningOrder = false;
  bool _hasChosenTime = false;
  List<bool> _cashCardSelection = [true, false];
  String _notes = "";
  double _currentCredit;
  double _modsContainerHeight = 0;

  List _cart = [
    //'["Margherita", "5", ["Senza pomodoro", 0]]',
    //["Marinara", "4.5", '[]']
  ];

  void clear() {
    cart.clear();
    _selectedItem = "";
    _selectedPrice = "";
    _selectedModsList.clear();
    _selectedMods = "";
    _hasSelected = true;
    _total = 0;
    _variationsButtonColor = Colors.deepPurple;
    _varButtonHeight = 40;
    _isAddingMod = false;
    _varContainerHeigth = 0;
    _varButtonPadding = 10;
    _deliveryTime = new TimeOfDay.now();
    _isHovering = false;
    _groupedCart = [];
    _oldCart = [];
    _notes = "";
    _hasChosenTime = false;
    _currentCredit = 0;
    _modsContainerHeight = 0;
    notifyListeners();
  }

  void setTotal(double newTotal) {
    _total = newTotal;
    notifyListeners();
  }

  void switchItemDetails(String name, String price, String mods) {
    _selectedItem = name;
    _selectedPrice = double.parse(price).toStringAsFixed(2);
    _selectedMods = mods;
    notifyListeners();
  }

  void addItem(String name, String price, String mods, String type) {
    _cart.add([
      [name, price, mods, type],
      [1]
    ]);
    calculateTotal();
    notifyListeners();
  }

  void duplicateItem(index) {
    final duplicateItem = _cart[index];
    _cart.add(duplicateItem);
    calculateTotal();
    notifyListeners();
  }

  void switchHasSelected(bool value) {
    _hasSelected = value;
    notifyListeners();
  }

  void getModsList(int index) {
    String modsString = cart[index][0][2];
    _selectedModsList = json.decode(modsString);
    _modsContainerHeight = 33 * _selectedModsList.length.toDouble();
    //notifyListeners();
  }

  void removeMod(int modIndex, int itemIndex) {
    double currentPrice = double.parse(_cart[itemIndex][0][1]);
    double modPrice = double.parse(_selectedModsList[modIndex][1]);
    double newPrice = currentPrice - modPrice;

    _modsContainerHeight -= 33;

    _cart[itemIndex][0][1] = newPrice.toString();
    _selectedModsList.removeAt(modIndex);
    _selectedMods = json.encode(_selectedModsList);
    cart[itemIndex][0][2] = _selectedMods;

    calculateTotal();

    notifyListeners();
  }

  void removeItem(index) {
    _cart.removeAt(index);
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    _total = 0;

    for (int i = 0; i < _cart.length; i++) {
      _total += double.parse(_cart[i][0][1]);
    }

    _currentCredit = double.parse(globals.credit);

    if (_total >= _currentCredit) {
      _total -= _currentCredit;
      _currentCredit = 0;
    }
    else {
      _currentCredit = _currentCredit - _total;
      _total = 0;
    }

    double dPercentage = _total / 100 * double.parse(globals.discount);
    _total -= dPercentage;
  }

  Future<void> updateCreditDatabase(String phone) async {
    var result = await FirebaseFirestore.instance
        .collection("customers")
        .where("phone", isEqualTo: globals.phone)
        .limit(1)
        .get()
        .then((query) {
      var order = query.docs[0];
      order.reference.update({
        "credit": _currentCredit.toString(),
      });
    });
  }

  void showVarContainer() {
    if (_isAddingMod) {
      _variationsButtonColor = Colors.deepPurpleAccent;
      _varButtonHeight = 30;
      _varContainerHeigth = 40;
      _varButtonPadding = 8;
    } else {
      _variationsButtonColor = Colors.deepPurple;
      _varButtonHeight = 40;
      _varContainerHeigth = 0;
      _varButtonPadding = 10;
    }
    notifyListeners();
  }

  void setIsAddingVar(bool bool) {
    _isAddingMod = bool;
    //showVarContainer();
    notifyListeners();
  }

  void addCurrentMod(String query, int selectedIndex) {
    List<String> abbreviations = SpeedyMenu().getVariationAbbreviations();
    int index = abbreviations.indexOf(query.toUpperCase());

    _modsContainerHeight += 33;

    _selectedModsList.add([
      SpeedyMenu.fullVariations[index][1],
      SpeedyMenu.fullVariations[index][3]
    ]);

    cart[selectedIndex][0][2] = json.encode(_selectedModsList);

    cart[selectedIndex][0][1] = json.encode(
        double.parse(cart[selectedIndex][0][1]) +
            double.parse(SpeedyMenu.fullVariations[index][3]));
    _selectedPrice = cart[selectedIndex][0][1];

    calculateTotal();

    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    if (time != null) {
      _deliveryTime = time;
    } else {
      _deliveryTime = TimeOfDay.now();
    }
    notifyListeners();
  }

  void switchIsHovering(bool bool) {
    _isHovering = bool;
    notifyListeners();
  }

  void groupItems() {
    _groupedCart.clear();
    var map = new Map();

    List cartStrings = [];
    List newCart = [];

    for (int i = 0; i < cart.length; i++) {
      newCart.add(json.encode([cart[i][0][0], cart[i][0][1], cart[i][0][2]]));
      cartStrings.add(newCart[i].toString());
    }

    cartStrings.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    List keys = map.keys.toList();
    List quantities = [];
    List items = [];

    for (int i = 0; i < keys.length; i++) {
      quantities.add([map[keys[i]]]);
      items.add(keys[i]);
      _groupedCart.add([json.decode(items[i]), quantities[i]]);
    }
  }

  void reopenCart(List newCart) {
    _cart = newCart;
    notifyListeners();
  }

  void switchIsReopeningOrder(bool value) {
    _isReopeningOrder = value;
    notifyListeners();
  }

  void switchHasChosenTime(bool value) {
    _hasChosenTime = value;
  }

  void setCashCardSelection(int index) {
    _cashCardSelection[index] = !_cashCardSelection[index];
    for(int i = 0; i < _cashCardSelection.length; i++) {
      if(i != index) {
        _cashCardSelection[i] = false;
      }
      else {
        _cashCardSelection[i] = true;
      }
    }
    notifyListeners();
  }

  void setNotes(String note) {
    _notes = note;
  }

  List get cart => _cart;

  String get selectedItem => _selectedItem;

  String get selectedPrice => _selectedPrice;

  String get selectedMods => _selectedMods;

  bool get hasSelected => _hasSelected;

  List get selectedModsList => _selectedModsList;

  double get total => _total;

  Color get variationsButtonColor => _variationsButtonColor;

  double get varButtonHeight => _varButtonHeight;

  bool get isAddingMod => _isAddingMod;

  double get varContainerHeight => _varContainerHeigth;

  double get varButtonPadding => _varButtonPadding;

  TimeOfDay get deliveryTime => _deliveryTime;

  bool get isHovering => _isHovering;

  List get groupedCart => _groupedCart;

  List get oldCart => _oldCart;

  bool get isReopeningOrder => _isReopeningOrder;

  bool get hasChosenTime => _hasChosenTime;

  List<bool> get cashCardSelection => _cashCardSelection;

  String get notes => _notes;

  double get currentCredit => _currentCredit;

  double get modsContainerHeight => _modsContainerHeight;
}
