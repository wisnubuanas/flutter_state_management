import 'package:flutter/material.dart';

class SaldoState with ChangeNotifier {
  int _saldo = 10000;

  int get getSaldo {
    return _saldo;
  }

  void kurangiSaldo(int cost) {
    _saldo -= cost;
    notifyListeners();
  }

  void tambahSaldo(int cost) {
    _saldo += cost;
    notifyListeners();
  }
}
