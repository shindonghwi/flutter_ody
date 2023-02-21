import 'package:flutter/material.dart';

class SelectorGenderProvider extends ChangeNotifier {
  bool _isSelected = true;

  bool get isSelected => _isSelected;

  void change() {
    _isSelected = !_isSelected;
    notifyListeners();
  }
}