import 'dart:io';
import 'package:first_app_flutter/screens/services/feedback_service.dart';
import 'package:first_app_flutter/screens/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FoundRoomServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = "";
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> checkData(DateTime checkIn, DateTime checkOut, int adults,
      int children, List<String> specialFacilities) async {
    setLoading(true);
    String checkInDate = DateFormat("yyyy-MM-dd").format(checkIn);
    String checkOutDate = DateFormat("yyyy-MM-dd").format(checkOut);
    if (checkInDate == checkOutDate) {
      setMessage('Please enter different date');
    } else if (checkOut.isBefore(DateTime.now())) {
      setMessage('Please enter a valid date');
    } else if (checkIn.isAfter(checkOut)) {
      setMessage('Check-in date is before check-out date');
    } else {
      foundRoom();
    }
    setLoading(false);
    notifyListeners();
  }

  Future<void> foundRoom() async {}

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
}
