import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/monthly_reservation_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/models/rooms_statistics.dart';
import 'package:first_app_flutter/models/staff_model.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:flutter/cupertino.dart';

class StatisticsService with ChangeNotifier {
  static final StatisticsService _singletonStatistics =
      StatisticsService._interval();
  StatisticsService._interval();
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

  List<RoomStatisticsModel> getRoomsStatistics() {
    return _roomStatistics;
  }

  factory StatisticsService() {
    return _singletonStatistics;
  }

  Future<void> getMonthlyReservationsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');
    _monthlyReservations.clear();
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

  Future<void> getMonthlyIncomeCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');
    _monthlyIncome.clear();
    DocumentSnapshot snapshot = await categories.doc('monthlyIncome').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var monthlyRData = data['monthly'] as List<dynamic>;
      for (var catData in monthlyRData) {
        MonthlyRModel m = MonthlyRModel.fromJson(catData);
        _monthlyIncome.add(m);
      }
    }
  }

  bool verifyExistingReservation(int month) {
    bool existing = false;
    for (var r in _monthlyReservations) {
      if (int.parse(r.month) == month) {
        existing = true;
      } else {
        existing = false;
      }
    }
    return existing;
  }

  bool verifyExistingIncome(int month) {
    bool existing = false;
    for (var r in _monthlyIncome) {
      if (int.parse(r.month) == month) {
        existing = true;
      } else {
        existing = false;
      }
    }
    return existing;
  }

  Future<void> calculateMonthlyReservations() async {
    DateTime dateToday = DateTime.now();
    int day = dateToday.day, month = dateToday.month;
    int countReservations = 0;
    if ((day == 1 && month != 12) ||
        (day == 31 && month == 12) && !verifyExistingReservation(month + 1)) {
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

  Future<void> calculateRoomsStatistics() async {
    RoomsService roomsService = RoomsService();
    _roomStatistics.clear();
    int free = 0, occupied = 0;
    for (var r in roomsService.getRooms()) {
      r.free ? free++ : occupied++;
    }
    _roomStatistics.add(
        RoomStatisticsModel(status: "free", value: free, color: "#124559"));
    _roomStatistics.add(RoomStatisticsModel(
        status: "occupied", value: occupied, color: "#f0972d"));
  }

  Future<void> calculateMonthlyIncome() async {
    DateTime dateToday = DateTime.now();
    int day = dateToday.day, month = dateToday.month;
    int revenue = 0;
    int costs = 0;
    int income = 0;

    if ((day == 1 && month != 12) ||
        (day == 31 && month == 12) && !verifyExistingIncome(month + 1)) {
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
