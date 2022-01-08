import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
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
      setMessage('Check-out date is before now');
    } else if (checkIn.isAfter(checkOut)) {
      setMessage('Check-in date is after check-out date');
    } else {
      await foundRoom(checkIn, checkOut, adults, children);
    }
    setLoading(false);
    notifyListeners();
  }

  Future<void> foundRoom(
      DateTime checkIn, DateTime checkOut, int adults, int children) async {
    _rooms.clear();
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');

    DocumentSnapshot snapshot = await users.doc('rooms').get();
    DocumentSnapshot reservations = await users.doc('reservations').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var roomsData = data['rooms'] as List<dynamic>;
      for (var roomData in roomsData) {
        RoomModel currentRoom = RoomModel.fromJson(roomData);
        bool isFoundRoomInReserv = false;
        if (int.parse(currentRoom.maxGuests) + 2 >= (adults + children)) {
          if (reservations.exists) {
            Map<String, dynamic> r =
                reservations.data() as Map<String, dynamic>;
            var reservationsData = r['reservations'] as List<dynamic>;
            List<DateTime> allDates = [];
            for (var booking in reservationsData) {
              ReservationModel r = ReservationModel.fromJson(booking);
              if (r.room == currentRoom.number) {
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
                _rooms.add(currentRoom);
              }
            }
          }
        }
        if (!isFoundRoomInReserv) {
          _rooms.add(currentRoom);
        }
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
