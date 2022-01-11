import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/monthly_reservation_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/models/rooms_statistics.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:flutter/cupertino.dart';

class StatisticsService with ChangeNotifier {
  FirebaseFirestore? _instance;
  final List<MonthlyRModel> _monthlyReservations = [];
  final List<MonthlyRModel> _monthlyIncome = [];
  final List<RoomStatisticsModel> _roomStatistics = [];

  List<MonthlyRModel> getMonthlyReservations() {
    return _monthlyReservations;
  }

  List<MonthlyRModel> getMonthlyIncome() {
    return _monthlyIncome;
  }

  StatisticsService() {
    getMonthlyReservationsCollectionFromFirebase();
    getMonthlyIncomeCollectionFromFirebase();
    getRoomStatisticsCollectionFromFirebase();
    // calculateMonthlyReservations();
    //calculateMonthlyIncome();
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

  Future<void> getRoomStatisticsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('roomStatistics').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomStatisticsData = data['roomStatistics'] as List<dynamic>;
      for (var catData in roomStatisticsData) {
        RoomStatisticsModel m = RoomStatisticsModel.fromJson(catData);
        _roomStatistics.add(m);
      }
    }
  }

  Future<void> getMonthlyIncomeCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('monthlyIncome').get();
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

  Future<void> calculateMonthlyIncome() async {
    DateTime dateToday = DateTime.now();
    int day = dateToday.day, month = dateToday.month;
    int revenue = 0;
    int costs = 0;
    int income = 0;

    if ((day == 1 && month != 12) || (day == 31 && month == 12)) {
      _instance = FirebaseFirestore.instance;
      CollectionReference categories = _instance!.collection('users');

      //calculez incasarile
      DocumentSnapshot snapshot = await categories.doc('reservations').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        var monthlyRData = data['reservations'] as List<dynamic>;
        for (var catData in monthlyRData) {
          ReservationModel r = ReservationModel.fromJson(catData);
          DateTime checkInDate = DateTime.parse(r.checkIn);

          if (checkInDate.month == month - 1) revenue += r.price;
        }
      }

      //calculez cheltuielile
      DocumentSnapshot snapshotTwo = await categories.doc('staff').get();
      if (snapshotTwo.exists) {
        Map<String, dynamic> data = snapshotTwo.data() as Map<String, dynamic>;
        var monthlyIncomeData = data['staff'] as List<dynamic>;
        for (var catData in monthlyIncomeData) {
          Staff r = Staff.fromJson(catData);
          costs += r.salary;
        }
      }
    }
    //calculezi pe luna respectiva venitul si adaug in bd
    income = revenue - costs;
    addMonthlyIncomeInFirebase((month - 1).toString(), income);
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

  Future<void> addMonthlyIncomeInFirebase(String month, int r) async {
    MonthlyRModel m = MonthlyRModel(month: month, numberOfR: r);
    DocumentReference<Map<String, dynamic>> users =
        FirebaseFirestore.instance.collection('users').doc('monthlyIncome');
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
