import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Archive extends ChangeNotifier {
  List _ordersList = [];
  List _singleOrder = [];
  DateTime _dtSelectedDate = DateTime.now();
  Future<double> _trackerHeight = Future<double>.value(400);
  List<String> _orderTimes = [];
  List<int> _amTimesSorted = [0, 0, 0, 0, 0, 0, 0];
  List<int> _pmTimesSorted = [0, 0, 0, 0, 0, 0, 0];
  List<int> _timesSorted = [0, 0, 0, 0, 0, 0, 0];
  List<int> _amDeliveryTimes = [0, 0, 0, 0, 0, 0, 0];
  List<int> _pmDeliveryTimes = [0, 0, 0, 0, 0, 0, 0];
  Key _orderTrackerKey = Key("sun");
  Key _statsKey = Key("stats");
  double _averageOrderSpend = 0;
  bool _dinner = false;
  FadeInImage _moonImage = FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: "https://i.imgur.com/ILWu3ne.png",
      key: Key("moon"));
  FadeInImage _sunImage = FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: "https://i.imgur.com/j31WSxG.png",
      key: Key("sun"));
  FadeInImage _imageShown;
  List _deliveryTimes = [];
  double _averageDeliveryTime = 0;

  void initialiseDate() {
    _dtSelectedDate = DateTime.now();
    _imageShown = _sunImage;
  }

  void updateKey() {
    _orderTrackerKey = UniqueKey();
    notifyListeners();
  }

  void clear() {
    _ordersList.clear();
    notifyListeners();
  }

  void clearSortedTimes() {
    _orderTimes.clear();
    _deliveryTimes.clear();
    _amTimesSorted = [0, 0, 0, 0, 0, 0, 0];
    _pmTimesSorted = [0, 0, 0, 0, 0, 0, 0];
    _timesSorted = [0, 0, 0, 0, 0, 0, 0];
    _pmDeliveryTimes = [0, 0, 0, 0, 0, 0, 0];
    _amDeliveryTimes = [0, 0, 0, 0, 0, 0, 0];
  }

  void addSingleOrder(String timePlaced, String deliveryTime, String phone, String nameSurname, String order, String total, String notes, bool cash, bool wasEdited, String datePlaced, String pony, String timeDelivered, int orderNumber) {
    _singleOrder.clear();
    _singleOrder.add([timePlaced, deliveryTime, phone, nameSurname, order, total, notes, cash, wasEdited, datePlaced, pony, timeDelivered, orderNumber]);
    notifyListeners();
  }

  void add(String timePlaced, String deliveryTime, String phone, String nameSurname, String order, String total, String notes, bool cash, bool wasEdited, String datePlaced, String pony, String timeDelivered, int orderNumber) {
    _ordersList.add([timePlaced, deliveryTime, phone, nameSurname, order, total, notes, cash, wasEdited, datePlaced, pony, timeDelivered, orderNumber]);
    calculateAverageOrder();
    calculateAverageDeliveryTime();
    notifyListeners();
  }

  void setDate(DateTime time) {
    _dtSelectedDate = time;
    notifyListeners();
  }

  void getOrderTimes() {
    for(int i = 0; i < _ordersList.length; i++) {
      _orderTimes.add(_ordersList[i][0]);
    }

      for(int i = 0; i < _orderTimes.length; i++) {

        //am times
        switch(_orderTimes[i].toString().substring(0, 2)) {
          case("10"): { _amTimesSorted[0] += 1; }
          break;

          case("11"): { _amTimesSorted[1] += 1; }
          break;

          case("12"): { _amTimesSorted[2] += 1; }
          break;

          case("13"): { _amTimesSorted[3] += 1; }
          break;

          case("14"): { _amTimesSorted[4] += 1; }
          break;

          case("15"): { _amTimesSorted[5] += 1; }
          break;

          case("16"): { _amTimesSorted[6] += 1; }
          break;

          //pm times

          case("17"): { _pmTimesSorted[0] += 1; }
          break;

          case("18"): { _pmTimesSorted[1] += 1; }
          break;

          case("19"): { _pmTimesSorted[2] += 1; }
          break;

          case("20"): { _pmTimesSorted[3] += 1; }
          break;

          case("21"): { _pmTimesSorted[4] += 1; }
          break;

          case("22"): { _pmTimesSorted[5] += 1; }
          break;

          case("23"): { _pmTimesSorted[6] += 1; }
          break;
        }
      }

      _timesSorted = _amTimesSorted;
  }

  void getDeliveryTimes() {
    for(int i = 0; i < _ordersList.length; i++) {
      _deliveryTimes.add(_ordersList[i][1]);
    }

    for(int i = 0; i < _deliveryTimes.length; i++) {

      //am times
      switch(_deliveryTimes[i].toString().substring(0, 2)) {
        case("10"): { _amDeliveryTimes[0] += 1; }
        break;

        case("11"): { _amDeliveryTimes[1] += 1; }
        break;

        case("12"): { _amDeliveryTimes[2] += 1; }
        break;

        case("13"): { _amDeliveryTimes[3] += 1; }
        break;

        case("14"): { _amDeliveryTimes[4] += 1; }
        break;

        case("15"): { _amDeliveryTimes[5] += 1; }
        break;

        case("16"): { _amDeliveryTimes[6] += 1; }
        break;

      //pm times
        case("17"): { _pmDeliveryTimes[0] += 1; }
        break;

        case("18"): { _pmDeliveryTimes[1] += 1; }
        break;

        case("19"): { _pmDeliveryTimes[2] += 1; }
        break;

        case("20"): { _pmDeliveryTimes[3] += 1; }
        break;

        case("21"): { _pmDeliveryTimes[4] += 1; }
        break;

        case("22"): { _pmDeliveryTimes[5] += 1; }
        break;

        case("23"): { _pmDeliveryTimes[6] += 1; }
        break;
      }
    }
  }

  void switchOrdersShown(bool value) {
    if(value) {
      _timesSorted = _pmTimesSorted;
    }
    else {
      _timesSorted = _amTimesSorted;
    }
    notifyListeners();
  }

  void calculateAverageOrder() {
    double total = 0;

    for(int i = 0; i < _ordersList.length; i++) {
      total += double.parse(_ordersList[i][5]);
    }

    _averageOrderSpend = total / _ordersList.length;

    notifyListeners();
  }

  void updateStatsKey() {
    _statsKey = UniqueKey();
    notifyListeners();
  }

  void calculateAverageDeliveryTime() {
    List<double> timeOrdered = [];
    List<double> timeDelivered = [];
    List<double> timeToPrepare = [];

      //turn times into minutes
      for(int i = 0; i < _ordersList.length; i++) {
        if((_ordersList[i][11].toString().isNotEmpty)) {
          double hours = double.parse(_ordersList[i][0].substring(0, 2));
          hours = hours * 60;
          double minutes = double.parse(ordersList[i][0].substring(3, 5));
          timeOrdered.add(minutes + hours);
        }
      }

      for(int i = 0; i < _ordersList.length; i++) {
        if(_ordersList[i][11].toString().isNotEmpty) {
          double hours = double.parse(_ordersList[i][11].toString().substring(0,2));
          hours = hours * 60;
          double minutes = double.parse(_ordersList[i][11].toString().substring(3,5));
          timeDelivered.add(minutes + hours);
        }
      }


    for(int i = 0; i < timeDelivered.length; i++) {
        if(timeDelivered[i] != 0) {
          timeToPrepare.add(timeDelivered[i] - timeOrdered[i]);
        }
      }

      double total = 0;
      timeToPrepare.forEach((timeDouble) {
        total += timeDouble;
      });

      _averageDeliveryTime = total / timeDelivered.length;


    notifyListeners();
  }

  void switchDinner(bool value) {
    _dinner = value;

    if(value) {
      _imageShown = _moonImage;
    }
    else {
      _imageShown = _sunImage;
    }

    notifyListeners();
  }

  void removeOrder(index) {
    _ordersList.removeAt(index);
    notifyListeners();
  }

  List get ordersList => _ordersList;
  List get singleOrder => _singleOrder;
  DateTime get dtSelectedDate => _dtSelectedDate;
  Future<double> get trackerHeight => _trackerHeight;
  List<int> get timesSorted => _timesSorted;
  Key get orderTrackerKey => _orderTrackerKey;
  Key get statsKey => _statsKey;
  double get averageOrderSpend => _averageOrderSpend;
  bool get dinner => _dinner;
  FadeInImage get imageShown => _imageShown;
  List get amDeliveryTimes => _amDeliveryTimes;
  List get pmDeliveryTimes => _pmDeliveryTimes;
  double get averageDeliveryTime => _averageDeliveryTime;
}