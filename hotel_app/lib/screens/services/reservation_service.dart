import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:flutter/cupertino.dart';

class ReservationService with ChangeNotifier {
  static final ReservationService _singletonReservations =
      ReservationService._interval();
  ReservationService._interval();
  FirebaseFirestore? _instance;
  final List<ReservationModel> _reservations = [];
  static int numberOfReservations = 0;
  List<ReservationModel> getReservations() {
    return _reservations;
  }

  factory ReservationService() {
    return _singletonReservations;
  }
  static int getNumberOfReservation() {
    return numberOfReservations;
  }

  Future<void> getReservationsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');
    _reservations.clear();
    DocumentSnapshot snapshot = await categories.doc('reservations').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var reservationsData = data['reservations'] as List<dynamic>;
      for (var r in reservationsData) {
        ReservationModel f = ReservationModel.fromJson(r);
        if (!verifyIfAlreadyReservationExist(f)) {
          _reservations.add(f);
        }
      }
    }
  }

  bool verifyIfAlreadyReservationExist(ReservationModel reservationModel) {
    for (var r in _reservations) {
      if (r.user == reservationModel.user &&
          r.checkIn == reservationModel.checkIn &&
          r.guests == reservationModel.guests &&
          r.checkOut == reservationModel.checkOut &&
          r.id == reservationModel.id &&
          r.price == reservationModel.price) return true;
    }
    return false;
  }

  Future<List<ReservationModel>> getReservationsFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');
    _reservations.clear();
    DocumentSnapshot snapshot = await categories.doc('reservations').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var reservationsData = data['reservations'] as List<dynamic>;
      for (var r in reservationsData) {
        ReservationModel f = ReservationModel.fromJson(r);
        _reservations.add(f);
      }
    }
    return _reservations;
  }

  Future<void> countNumberOfReservations(String? email) async {
    await getReservationsCollectionFromFirebase();
    numberOfReservations = 0;
    for (var r in _reservations) {
      if (r.user == email && r.approved) numberOfReservations++;
    }
  }

  Future<void> addReservationsInFirebase(ReservationModel f) async {
    DocumentReference<Map<String, dynamic>> reservations =
        FirebaseFirestore.instance.collection('users').doc('reservations');
    _reservations.add(f);
    // sortReservationByDate();
    final reservationsMap = <Map<String, dynamic>>[];
    for (var f in _reservations) {
      reservationsMap.add(f.toJson());
    }
    reservations.set({
      'reservations': reservationsMap,
    });
  }

  Future<void> deleteReservation(ReservationModel r) async {
    _reservations.remove(r);
    DocumentReference<Map<String, dynamic>> reservations =
        FirebaseFirestore.instance.collection('users').doc('reservations');

    final reservationsMap = <Map<String, dynamic>>[];
    for (int i = 0; i < _reservations.length; i++) {
      reservationsMap.add(_reservations[i].toJson());
    }
    reservations.set({
      'reservations': reservationsMap,
    });
  }

  Future<void> updateReservationInFirebase(String id) async {
    DocumentReference<Map<String, dynamic>> reservations =
        FirebaseFirestore.instance.collection('users').doc('reservations');

    for (int i = 0; i < _reservations.length; i++) {
      if (_reservations[i].id == id) {
        _reservations[i].approved = true;
      }
    }
    final reservationsMap = <Map<String, dynamic>>[];
    for (int i = 0; i < _reservations.length; i++) {
      reservationsMap.add(_reservations[i].toJson());
    }
    reservations.set({
      'reservations': reservationsMap,
    });
  }
}
