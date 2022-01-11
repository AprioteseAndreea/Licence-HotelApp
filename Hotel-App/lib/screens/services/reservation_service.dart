import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:flutter/cupertino.dart';

class ReservationService with ChangeNotifier {
  FirebaseFirestore? _instance;
  final List<ReservationModel> _reservations = [];

  List<ReservationModel> getReservations() {
    return _reservations;
  }

  ReservationService() {
    getReservationsCollectionFromFirebase();
    actualizeInformation();
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
        _reservations.add(f);
      }
    }
    // sortReservationByDate();
  }

  Future<void> actualizeInformation() async {
    RoomsService roomsService = RoomsService();
    _reservations.clear();
    await getReservationsCollectionFromFirebase();
    for (var r in _reservations) {
      DateTime checkOutReserv = DateTime.parse(r.checkOut);
      DateTime checkInReserv = DateTime.parse(r.checkIn);

      DateTime now = DateTime.now();
      if (checkOutReserv.isAfter(now) && checkInReserv.isBefore(now)) {
        roomsService.updateRoomStatusInFirebase(
            r.room, "free", r.name, '$checkInReserv - $checkOutReserv');
      } else {
        roomsService.updateRoomStatusInFirebase(r.room, "occupied", r.name,
            '${checkInReserv.day}/${checkInReserv.month} - ${checkOutReserv.day}/${checkOutReserv.month}');
      }
    }
  }
  //
  // Future<void> sortReservationByDate() async {
  //   _reservations.sort((a, b) => a.date.compareTo(b.date));
  // }

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

  Future<void> updateReservationInFirebase(String id) async {
    DocumentReference<Map<String, dynamic>> reservations =
        FirebaseFirestore.instance.collection('users').doc('reservations');

    for (int i = 0; i < _reservations.length; i++) {
      if (_reservations[i].id == id) {
        _reservations[i].approved = true;
      }
    }
    final reservationsMap = <Map<String, dynamic>>[];
    for (int i = 0; i < _reservations.length / 2; i++) {
      reservationsMap.add(_reservations[i].toJson());
    }
    reservations.set({
      'reservations': reservationsMap,
    });
  }
}
