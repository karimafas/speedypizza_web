import 'package:flutter/cupertino.dart';

class Analytics extends ChangeNotifier {
  int _selectedIndex = 0;
  int _selectedBtnIndex = 0;
  bool _hasClicked = false;

  changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  changeBtnIndex(int newBtnIndex) {
    _selectedBtnIndex = newBtnIndex;
    notifyListeners();
  }

  click(){
    _hasClicked = !_hasClicked;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
  int get selectedBtnIndex => _selectedBtnIndex;
  bool get hasClicked => _hasClicked;
}
