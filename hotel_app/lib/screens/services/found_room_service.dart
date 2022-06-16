import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:trotter/trotter.dart';

class FoundRoomServices with ChangeNotifier {
  FirebaseFirestore? _instance;
  bool _isLoading = false;
  String _errorMessage = "";
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  late RoomModel roomModel;
  late List<RoomModel> _rooms = [];

  Future<void> checkData(DateTime checkIn, DateTime checkOut, int adults,
      int children, int rooms, List<FacilityModel> specialFacilities) async {
    setLoading(true);
    String checkInDate = DateFormat("yyyy-MM-dd").format(checkIn);
    String checkOutDate = DateFormat("yyyy-MM-dd").format(checkOut);
    if (checkInDate == checkOutDate) {
      setMessage('Please enter different date');
    } else if (checkIn.isBefore(DateTime.now())) {
      setMessage('Check-in date is before now');
    } else if (checkOut.isBefore(DateTime.now())) {
      setMessage('Check-out date is before now');
    } else if (checkIn.isAfter(checkOut)) {
      setMessage('Check-in date is after check-out date');
    } else {
      await foundRoom(checkIn, checkOut, adults, children, rooms);
    }
    setLoading(false);
    notifyListeners();
  }

  Future<void> foundRoom(DateTime checkIn, DateTime checkOut, int adults,
      int children, int rooms) async {
    _rooms.clear();
    List<RoomModel> resultedList = [];
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');

    DocumentSnapshot snapshot = await users.doc('rooms').get();
    DocumentSnapshot reservations = await users.doc('reservations').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['rooms'] as List<dynamic>;
      for (var roomData in roomsData) {
        //caut toate camerele disponibile in perioada respectiva
        RoomModel currentRoom = RoomModel.fromJson(roomData);
        bool isFoundRoomInReserv = false;

        if (reservations.exists) {
          Map<String, dynamic> r = reservations.data() as Map<String, dynamic>;
          var reservationsData = r['reservations'] as List<dynamic>;
          List<DateTime> allDates = [];
          for (var booking in reservationsData) {
            ReservationModel r = ReservationModel.fromJson(booking);
            if (r.rooms.contains(currentRoom.number)) {
              isFoundRoomInReserv = true;
              DateTime checkInReserv = DateTime.parse(r.checkIn);
              DateTime checkOutReserv = DateTime.parse(r.checkOut);
              allDates.add(checkInReserv);
              allDates.add(checkOutReserv);
            }
          }
          bool okCheckIn = true;
          bool okCheckOut = true;
          for (var i = 0; i < allDates.length; i += 2) {
            if (allDates[i] == checkIn ||
                (allDates[i].isAfter(checkIn) &&
                    allDates[i].isBefore(checkOut))) {
              okCheckIn = false;
              break;
            }
          }

          if (okCheckIn == true) {
            for (var i = 1; i < allDates.length; i += 2) {
              if (allDates[i] == checkOut ||
                  (allDates[i].isAfter(checkIn) &&
                      allDates[i].isBefore(checkOut))) {
                okCheckOut = false;
              }
            }
            if (okCheckOut == true) {
              if (!_rooms.contains(currentRoom)) {
                _rooms.add(currentRoom);
              }
            }
          }
        }

        if (!isFoundRoomInReserv) {
          if (!_rooms.contains(currentRoom)) {
            _rooms.add(currentRoom);
          }
        }
      }

      int sumaMaxGuests = 0;
      for (var r in _rooms) {
        sumaMaxGuests += int.parse(r.maxGuests);
      }
      //verific daca avem suficiente camere libere car ar putea satisface cererea
      //atat dpdv al numarului de camere cat si al numarului de oaspeti
      if (_rooms.length <= rooms || sumaMaxGuests < (adults + children)) {
        _rooms.clear();
      }

      //generam combinar de n luate cate k camere
      //n = numarul total de camere disponibile in perioada respectiva
      //k = numar de camere cerute de utilizator

      //daca avem suficiente camere vom incerca sa gasim cea mai buna combinatie
      if (_rooms.length >= rooms) {
        final totalRooms = characters('');
        for (int i = 0; i < rooms; i++) {
          totalRooms.add(i.toString());
        }
        final combos = Combinations(rooms, totalRooms);
        int minDifference = 3;
        for (final combo in combos()) {
          int maxGuests = 0;
          for (var c in combo) {
            maxGuests += int.parse(_rooms[int.parse(c)].maxGuests);
          }
          //verific daca camera/grupul de camere poate sa-mi cazeze numarul
          // de oaspeti ceruti

          if (maxGuests >= (adults + children)
              //&& (maxGuests - adults - children < minDifference)
              ) {
            for (var c in combo) {
              resultedList.add(_rooms[int.parse(c)]);
            }
          }
        }
        //sortam lista rezultata crescator dupa diferenta dintre
        // maxGuests si (adults + children)

        _rooms = resultedList;
      }
    }
  }

  List<RoomModel> getRooms() {
    return _rooms;
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
}
