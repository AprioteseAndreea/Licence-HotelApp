import 'package:flutter/material.dart';

import 'data.dart';

class SingleNotifier extends ChangeNotifier {
  String _currentCountry = countries[0];
  SingleNotifier();

  String get currentCountry => _currentCountry;

  updateCountry(String value) {
    if (value != _currentCountry) {
      _currentCountry = value;
      notifyListeners();
    }
  }
}

class MultipleNotifier extends ChangeNotifier {
  final List<String> _selectedItems;
  MultipleNotifier(this._selectedItems);
  List<String> get selectedItems => _selectedItems;

  bool isHaveItem(String value) => _selectedItems.contains(value);

  addItem(String value) {
    if (!isHaveItem(value)) {
      _selectedItems.add(value);
      notifyListeners();
    }
  }

  removeItem(String value) {
    if (isHaveItem(value)) {
      _selectedItems.remove(value);
      notifyListeners();
    }
  }
}
