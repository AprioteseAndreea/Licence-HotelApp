import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/monthly_reservation_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class StatisticsService with ChangeNotifier {
  FirebaseFirestore? _instance;
  final List<MonthlyRModel> _monthlyReservations = [];

  List<MonthlyRModel> getMonthlyReservations() {
    return _monthlyReservations;
  }

  StatisticsService() {
    getMonthlyReservationsCollectionFromFirebase();
    calculateMonthlyReservations();
  }

  Future<void> getMonthlyReservationsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot =
        await categories.doc('monthlyReservations').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var monthlyRData = data['monthly'] as List<dynamic>;
      for (var catData in monthlyRData) {
        MonthlyRModel m = MonthlyRModel.fromJson(catData);
        _monthlyReservations.add(m);
      }
    }
  }

  Future<void> calculateMonthlyReservations() async {
    DateTime dateToday = DateTime.now();
    int day = dateToday.day, month = dateToday.month;
    int countReservations = 0;
    if ((day == 1 && month != 12) || (day == 31 && month == 12)) {
      _instance = FirebaseFirestore.instance;
      CollectionReference categories = _instance!.collection('users');

      DocumentSnapshot snapshot = await categories.doc('reservations').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        var monthlyRData = data['reservations'] as List<dynamic>;
        for (var catData in monthlyRData) {
          ReservationModel r = ReservationModel.fromJson(catData);
          DateTime checkInDate = DateTime.parse(r.checkIn);

          if (checkInDate.month == month - 1) countReservations++;
        }
      }
    }
    addMonthlyReservationInFirebase((month - 1).toString(), countReservations);
  }

  Future<void> addMonthlyReservationInFirebase(String month, int r) async {
    MonthlyRModel m = MonthlyRModel(month: month, numberOfR: r);
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc('monthlyReservations');
    _monthlyReservations.add(m);
    final reservMap = <Map<String, dynamic>>[];
    for (var user in _monthlyReservations) {
      reservMap.add(user.toJson());
    }
    users.set({
      'monthly': reservMap,
    });
  }
}
