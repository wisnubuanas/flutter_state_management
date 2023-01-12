import 'package:flutter/material.dart';

class ColorState with ChangeNotifier {
  bool _isOrange = false;

  bool get getIsOrange {
    return _isOrange;
  }

  Color get getColor {
    return _isOrange ? Colors.red.shade900 : Colors.green.shade900;
  }

  set setColor(bool value) {
    _isOrange = value;
    notifyListeners();
  }
}
