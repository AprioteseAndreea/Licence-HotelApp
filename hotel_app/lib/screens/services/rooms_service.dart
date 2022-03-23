import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:flutter/cupertino.dart';

class RoomsService with ChangeNotifier {
  FirebaseFirestore? _instance;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  final List<RoomModel> _rooms = [];

  List<RoomModel> getRooms() {
    return _rooms;
  }

  RoomsService() {
    getRoomsCollectionFromFirebase();
  }
  Future<void> getRoomsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');

    DocumentSnapshot snapshot = await users.doc('rooms').get();
    //DocumentSnapshot reservations = await users.doc('reservations').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['rooms'] as List<dynamic>;
      for (var roomData in roomsData) {
        RoomModel room = RoomModel.fromJson(roomData);
        _rooms.add(room);
      }
    }
  }

  bool verifyRoomNumber(String number) {
    bool ok = true;
    for (var f in _rooms) {
      if (f.number == number) {
        ok = false;
        setMessage('Room number already exist!');
        break;
      }
    }
    return ok;
  }

  Future<void> addRoomInFirebase(RoomModel f) async {
    if (verifyRoomNumber(f.number)) {
      DocumentReference<Map<String, dynamic>> rooms =
          FirebaseFirestore.instance.collection('users').doc('rooms');
      _rooms.add(f);
      final roomsMap = <Map<String, dynamic>>[];
      for (var f in _rooms) {
        roomsMap.add(f.toJson());
      }
      rooms.set({
        'rooms': roomsMap,
      });
    }
  }

  Future<void> updateRoomInFirebase(RoomModel r) async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('rooms');

    for (int i = 0; i < _rooms.length; i++) {
      if (_rooms[i].number == r.number) {
        _rooms[i].maxGuests = r.maxGuests;
        _rooms[i].cost = r.cost;
        _rooms[i].facilities = r.facilities;
        _rooms[i].free = r.free;
        _rooms[i].idUser = r.idUser;
        _rooms[i].interval = r.interval;
      }
    }
    final roomsMap = <Map<String, dynamic>>[];
    for (var f in _rooms) {
      roomsMap.add(f.toJson());
    }
    rooms.set({
      'rooms': roomsMap,
    });
  }

  Future<void> updateRoomStatusInFirebase(String roomNumber, String status,
      String? userName, String? interval) async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('rooms');

    for (int i = 0; i < _rooms.length; i++) {
      if (_rooms[i].number == roomNumber) {
        if (status == "free") {
          _rooms[i].free = true;
          _rooms[i].idUser = "none";
          _rooms[i].interval = "none";
        }
        if (status == "occupied") {
          _rooms[i].free = false;
          _rooms[i].idUser = userName!;
          _rooms[i].interval = interval!;
        }
      }
    }
    final roomsMap = <Map<String, dynamic>>[];
    for (var f in _rooms) {
      roomsMap.add(f.toJson());
    }
    rooms.set({
      'rooms': roomsMap,
    });
  }

  Future<void> deleteRoomInFirebase(RoomModel r) async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('rooms');

    for (int i = 0; i < _rooms.length; i++) {
      if (_rooms[i].number == r.number) {
        _rooms.remove(_rooms[i]);
      }
    }
    final roomsMap = <Map<String, dynamic>>[];
    for (var f in _rooms) {
      roomsMap.add(f.toJson());
    }
    rooms.set({
      'rooms': roomsMap,
    });
  }
}
