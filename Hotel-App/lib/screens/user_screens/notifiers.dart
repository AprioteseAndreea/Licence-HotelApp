import 'package:first_app_flutter/models/extra_facility_model.dart';
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
  final List<FacilityModel> _selectedItems;
  MultipleNotifier(this._selectedItems);
  List<FacilityModel> get selectedItems => _selectedItems;

  bool isHaveItem(FacilityModel value) => _selectedItems.contains(value);

  addItem(FacilityModel value) {
    if (!isHaveItem(value)) {
      _selectedItems.add(value);
      notifyListeners();
    }
  }

  removeItem(FacilityModel value) {
    if (isHaveItem(value)) {
      _selectedItems.remove(value);
      notifyListeners();
    }
  }
}
