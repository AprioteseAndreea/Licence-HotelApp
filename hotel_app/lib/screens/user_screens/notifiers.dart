import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class SingleNotifier extends ChangeNotifier {
  String _currentOccupation = Strings.countries[0];
  SingleNotifier();

  String get currentCountry => _currentOccupation;

  updateOccupation(String value) {
    if (value != _currentOccupation) {
      _currentOccupation = value;
      notifyListeners();
    }
  }

  bool isHaveItem(String value) => currentCountry == value;
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
