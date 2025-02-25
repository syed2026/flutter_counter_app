import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void decrement() {
    _value--;
    notifyListeners();
  }

  void setValue(int newValue) {
    _value = newValue;
    notifyListeners();
  }
}
