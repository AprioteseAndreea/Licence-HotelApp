import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/reservation_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/services/reservation_service.dart';
import 'package:first_app_flutter/screens/user_screens/confirm_reservation.dart';
import 'package:first_app_flutter/screens/user_screens/not_found_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class GetRoomS2 extends StatefulWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults, children;
  final List<FacilityModel> selectedSpecialFacilities;
  final RoomModel room;

  const GetRoomS2(
      {Key? key,
      required this.checkInDate,
      required this.checkOutDate,
      required this.adults,
      required this.children,
      required this.selectedSpecialFacilities,
      required this.room})
      : super(key: key);
  @override
  _GetRoomS2 createState() => _GetRoomS2();
}

class _GetRoomS2 extends State<GetRoomS2> {
  late String facilitiesEnumeration = '';
  late int extraBeds;
  late int extraFacilities = 0;
  late int roomCost = 0;
  late int nights = 0;
  late int total = 0;
  @override
  void initState() {
    super.initState();
    for (var f in super.widget.selectedSpecialFacilities) {
      facilitiesEnumeration += (" • ") + f.facility;
      extraFacilities += int.parse(f.cost);
    }
    if (int.parse(super.widget.room.maxGuests) <
        (super.widget.adults + super.widget.children)) {
      extraBeds = (super.widget.adults + super.widget.children) -
          int.parse(super.widget.room.maxGuests);
    } else {
      extraBeds = 0;
    }
    nights =
        super.widget.checkOutDate.difference(super.widget.checkInDate).inDays +
            1;
    roomCost = int.parse(super.widget.room.cost) * nights;
    total = roomCost + (extraBeds * 10) + extraFacilities;
  }

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationService>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Grand Hotel',
          style: TextStyle(color: Color(0xFF124559)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepProgressIndicator(
                totalSteps: 3,
                currentStep: 2,
                size: 13,
                selectedColor: Color(0xFF124559),
                unselectedColor: Color(0xFF72B0D4),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      'CHECK-IN DATE',
                      style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'CHECK-OUT DATE',
                      style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, bottom: 8, top: 10),
                              child: Text('${super.widget.checkInDate.day}',
                                  style: const TextStyle(
                                      fontSize: 25, color: Color(0xFF49758B))),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(
                                Icons.horizontal_rule_rounded,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' ${super.widget.checkInDate.year}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFF0972D),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.MMMM()
                                        .format(super.widget.checkInDate),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF124559),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, bottom: 8, top: 10),
                              child: Text('${super.widget.checkOutDate.day}',
                                  style: const TextStyle(
                                      fontSize: 25, color: Color(0xFF49758B))),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(
                                Icons.horizontal_rule_rounded,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' ${super.widget.checkOutDate.year}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFF0972D),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.MMMM()
                                        .format(super.widget.checkOutDate),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF124559),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/people.png',
                              height: 50,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${(super.widget.adults + super.widget.children)}',
                              style: const TextStyle(
                                  color: Color(0xFFF0972D),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'guests',
                              style: TextStyle(
                                  color: Color(0xFF124559),
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.horizontal_rule_rounded,
                              color: Colors.grey,
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'assets/images/night.png',
                              height: 50,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$nights',
                              style: const TextStyle(
                                  color: Color(0xFFF0972D),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'nights',
                              style: TextStyle(
                                  color: Color(0xFF124559),
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'FACILITIES',
                              style: TextStyle(
                                  color: Color(0xFF124559),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    constraints: const BoxConstraints(
                                        minWidth: 100, maxWidth: 250),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      facilitiesEnumeration,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Color(0xFF124559)),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/facilities.png',
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xFF124559),
                thickness: 2,
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'ROOM ${super.widget.room.number}',
                        style: const TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      // subtitle: const Text(
                      //   'FACILITIES: ',
                      //   style: TextStyle(
                      //     color: Color(0xFF124559),
                      //     fontSize: 13,
                      //   ),
                      // ),
                      leading: Image.asset(
                        'assets/images/key.jpg',
                        height: 50,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.euro,
                            color: Color(0xFF124559),
                            size: 25.0,
                          ),
                          Text(
                            super.widget.room.cost,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF72B0D4),
                            ),
                          ),
                          const Text(
                            '/night',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF124559),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'For this room you need to buy more $extraBeds beds',
                    style: const TextStyle(
                      color: Color(0xFF124559),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        'Room',
                        style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 17,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.euro,
                            color: Color(0xFF124559),
                            size: 25.0,
                          ),
                          Text(
                            '$roomCost',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF72B0D4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Extra beds',
                        style: TextStyle(
                          color: Color(0xFF124559),
                          fontSize: 17,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.euro,
                            color: Color(0xFF124559),
                            size: 25.0,
                          ),
                          Text(
                            '${extraBeds * 10}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF72B0D4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Extra Facilities',
                        style:
                            TextStyle(color: Color(0xFF124559), fontSize: 17),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.euro,
                            color: Color(0xFF124559),
                            size: 25.0,
                          ),
                          Text(
                            '$extraFacilities',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF72B0D4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Total:',
                        style: TextStyle(
                            color: Color(0xFFF0972D),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.euro,
                            color: Color(0xFF124559),
                            size: 25.0,
                          ),
                          Text(
                            '$total',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF72B0D4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      List<String> facilities = [];
                      for (var f in super.widget.selectedSpecialFacilities) {
                        facilities.add(f.facility);
                      }
                      final _prefs = await SharedPreferences.getInstance();
                      final _value = _prefs.getString('email');
                      if (_value != null) {
                        ReservationModel r = ReservationModel(
                            checkIn: super.widget.checkInDate.toString(),
                            checkOut: super.widget.checkOutDate.toString(),
                            price: total,
                            room: super.widget.room.number,
                            user: _value,
                            approved: false,
                            facilities: facilities,
                            guests:
                                super.widget.adults + super.widget.children);

                        reservationProvider.addReservationsInFirebase(r);
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfirmReservation(),
                          ));
                    },
                    height: 40,
                    minWidth: 200,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Confirm reservation",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
