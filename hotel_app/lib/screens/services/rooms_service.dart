import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:flutter/cupertino.dart';

class RoomsService with ChangeNotifier {
  static final RoomsService _singletonRooms = RoomsService._interval();
  RoomsService._interval();

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

  factory RoomsService() {
    return _singletonRooms;
  }

  Future<void> getRoomsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');
    _rooms.clear();
    DocumentSnapshot snapshot = await users.doc('rooms').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['rooms'] as List<dynamic>;
      for (var roomData in roomsData) {
        RoomModel room = RoomModel.fromJson(roomData);
        if (!verifyIfRoomAlreadyExist(room)) {
          _rooms.add(room);
        }
      }
    }
    await actualizeInformation();
  }

  Future<void> actualizeInformation() async {
    ReservationService reservationService = ReservationService();
    for (int i = 0; i < _rooms.length; i++) {
      _rooms[i].idUser = "none";
      _rooms[i].interval = "none";
      _rooms[i].free = true;
    }
    for (var r in _rooms) {
      for (var reservation in reservationService.getReservations()) {
        DateTime checkOutReserv = DateTime.parse(reservation.checkOut);
        DateTime checkInReserv = DateTime.parse(reservation.checkIn);
        DateTime now = DateTime.now();
        if (checkInReserv.isBefore(now) &&
            checkOutReserv.isAfter(now) &&
            reservation.rooms.contains(r.number)) {
          updateRoom(r.number, "occupied", reservation.name!,
              '${checkInReserv.day}/${checkInReserv.month} - ${checkOutReserv.day}/${checkOutReserv.month}');
          break;
        }
      }
    }
    await updateRoomStatusInFirebase();
  }

  bool verifyIfRoomAlreadyExist(RoomModel roomModel) {
    for (var r in _rooms) {
      if (r.number == roomModel.number) return true;
    }
    return false;
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

  Future<void> updateRoomStatusInFirebase() async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('rooms');
    final roomsMap = <Map<String, dynamic>>[];
    for (var f in _rooms) {
      roomsMap.add(f.toJson());
    }
    rooms.set({
      'rooms': roomsMap,
    });
  }

  void updateRoom(
      String roomNumber, String status, String userName, String interval) {
    for (int i = 0; i < _rooms.length; i++) {
      if (_rooms[i].number == roomNumber) {
        if (status == "free") {
          _rooms[i].free = true;
          _rooms[i].idUser = "none";
          _rooms[i].interval = "none";
        }
        if (status == "occupied") {
          _rooms[i].free = false;
          _rooms[i].idUser = userName;
          _rooms[i].interval = interval;
        }
      }
    }
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
