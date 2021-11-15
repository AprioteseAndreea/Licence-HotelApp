import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:flutter/cupertino.dart';

class RoomsService with ChangeNotifier {
  FirebaseFirestore? _instance;

  final List<RoomModel> _rooms = [];

  List<RoomModel> getRooms() {
    return _rooms;
  }

  RoomsService() {
    getRoomsCollectionFromFirebase();
  }
  Future<void> getRoomsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('users');

    DocumentSnapshot snapshot = await categories.doc('rooms').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['rooms'] as List<dynamic>;
      for (var roomData in roomsData) {
        RoomModel room = RoomModel.fromJson(roomData);
        _rooms.add(room);
      }
    }
  }

  Future<void> addRoomInFirebase(RoomModel f) async {
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

  Future<void> updateRoomInFirebase(RoomModel r) async {
    DocumentReference<Map<String, dynamic>> rooms =
        FirebaseFirestore.instance.collection('users').doc('rooms');

    for (int i = 0; i < _rooms.length; i++) {
      if (_rooms[i].number == r.number) {
        _rooms[i].maxGuests = r.maxGuests;
        _rooms[i].cost = r.cost;
        _rooms[i].facilities = r.facilities;
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
