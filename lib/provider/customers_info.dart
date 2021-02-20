import 'package:flutter/cupertino.dart';

class CustomersInfo extends ChangeNotifier {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _chosenController = new TextEditingController();
  bool _isQuerying = false;
  String _queryType = "";

  changeController(String type) {
    if(type == "name") {
      _isQuerying = true;
      _chosenController = _nameController;
      _queryType = "name";
    }
    if(type == "surname") {
      _isQuerying = true;
      _chosenController = _surnameController;
      _queryType = "surname";
    }
    if(type == "phone") {
      _isQuerying = true;
      _chosenController = _phoneController;
      _queryType = "phone";
    }

    notifyListeners();
  }

  switchIsQuerying(bool value) {
    _isQuerying = value;
    notifyListeners();
  }

  TextEditingController get nameController => _nameController;
  TextEditingController get surnameController => _surnameController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get chosenController => _chosenController;
  bool get isQuerying => _isQuerying;
  String get queryType => _queryType;
}