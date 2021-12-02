import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:flutter/cupertino.dart';

class ReservationService with ChangeNotifier {
  FirebaseFirestore? _instance;
  final List<ReservationModel> _reservations = [];

  List<ReservationModel> getReservations() {
    return _reservations;
  }

  ReservationService() {
    getReservationsCollectionFromFirebase();
  }
  Future<void> getReservationsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('reservations').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var reservationsData = data['reservations'] as List<dynamic>;
      for (var r in reservationsData) {
        ReservationModel f = ReservationModel.fromJson(r);
        _reservations.add(f);
      }
    }
  }

  Future<void> addReservationsInFirebase(ReservationModel f) async {
    DocumentReference<Map<String, dynamic>> reservations =
        FirebaseFirestore.instance.collection('users').doc('reservations');
    _reservations.add(f);
    final reservationsMap = <Map<String, dynamic>>[];
    for (var f in _reservations) {
      reservationsMap.add(f.toJson());
    }
    reservations.set({
      'reservations': reservationsMap,
    });
  }
}
