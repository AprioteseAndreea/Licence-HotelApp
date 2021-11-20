import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class FoundRoomServices with ChangeNotifier {
  FirebaseFirestore? _instance;
  bool _isLoading = false;
  String _errorMessage = "";
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  late RoomModel roomModel;
  final List<RoomModel> _rooms = [];

  Future<void> checkData(DateTime checkIn, DateTime checkOut, int adults,
      int children, List<FacilityModel> specialFacilities) async {
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

  Future<void> foundRoom() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');

    DocumentSnapshot snapshot = await users.doc('rooms').get();
    DocumentSnapshot reservations = await users.doc('reservations').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['rooms'] as List<dynamic>;
      for (var roomData in roomsData) {
        //if guests ... atunci caut in rezervari
        if (reservations.exists) {
          //trebuie creat modelul pt rezervari si prelucrat timestampul din BD
          Map<String, dynamic> r = reservations.data() as Map<String, dynamic>;
          var reservationsData = r['reservations'] as List<dynamic>;

          for (var reserv in reservationsData) {}
        }

        RoomModel room = RoomModel.fromJson(roomData);
        _rooms.add(room);
      }
    }
  }
  // Future<RoomModel> foundRoom() async {
  //   List<String> facilities = [];
  //   roomModel = RoomModel(
  //       number: "undefined",
  //       cost: "100",
  //       maxGuests: "3",
  //       free: true,
  //       pending: false,
  //       idUser: "undefined",
  //       interval: "undefined",
  //       facilities: facilities);
  //   return roomModel;
  // }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
}
