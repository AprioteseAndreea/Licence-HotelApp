import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/authentication/authentication_services/auth_services.dart';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/screens/services/found_room_service.dart';
import 'package:first_app_flutter/screens/user_screens/get_room_possible_rooms.dart';
import 'package:first_app_flutter/screens/user_screens/not_found_room.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'notifiers.dart';

class GetRoom extends StatefulWidget {
  const GetRoom({Key? key}) : super(key: key);
  @override
  _GetRoom createState() => _GetRoom();
}

class _GetRoom extends State<GetRoom> {
  TextEditingController nameController = TextEditingController();
  late TextEditingController _otherDetailsController = TextEditingController();

  late DateTime checkIn = DateTime.now();
  late DateTime checkOut = DateTime.now();

  late String day = '', email = '', name = '';
  late String checkInFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late String checkOutFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());

  int adults = 1;
  int children = 0;
  int rooms = 1;
  List<FacilityModel> facilitiesCollection = [];
  List<FacilityModel> selectedSpecialFacilities = [];

  late FacilityService facilityService = FacilityService();

  AuthServices authServices = AuthServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    facilitiesCollection = facilityService.getFacilities();
    _otherDetailsController = TextEditingController();

    name = firebaseAuth.currentUser!.displayName!;
    email = firebaseAuth.currentUser!.email!;

    super.initState();
    initializeDateFormatting();
  }

  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _multipleNotifier = Provider.of<MultipleNotifier>(context);
        return AlertDialog(
          title: const Text('Select your special facilities'),
          content: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: facilitiesCollection
                      .map((e) => CheckboxListTile(
                            title: Text(
                                '${e.facility} - ${e.cost}€/${e.interval}'),
                            onChanged: (value) {
                              if (value != null) {
                                value
                                    ? _multipleNotifier.addItem(e)
                                    : _multipleNotifier.removeItem(e);
                              }
                            },
                            value: _multipleNotifier.isHaveItem(e),
                          ))
                      .toList(),
                )),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                selectedSpecialFacilities = _multipleNotifier.selectedItems;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
  Future<void> _checkInDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (d != null) {
      setState(() {
        checkIn = DateTime(d.year, d.month, d.day, 14, 0, 0);
        checkInFormat = DateFormat('dd-MM-yyyy').format(checkIn);
      });
    }
  }

  incrementAdults(BuildContext context) {
    setState(() {
      if (adults < 5) {
        adults++;
      }
      if (adults > 3) {
        rooms++;
      }
    });
  }

  decrementAdults(BuildContext context) {
    setState(() {
      if (adults > 1) {
        adults--;
      }
      if (rooms > 1) {
        rooms--;
      }
    });
  }

  incrementRooms(BuildContext context) {
    setState(() {
      if (rooms < 20) {
        rooms++;
      }
      if (adults < rooms) {
        adults++;
      }
    });
  }

  decrementRooms(BuildContext context) {
    setState(() {
      if (rooms > 1) {
        rooms--;
      }
      if (adults > rooms * 3) {
        adults--;
      }
    });
  }

  incrementChildren(BuildContext context) {
    setState(() {
      if (children < 5) {
        children++;
      }
    });
  }

  decrementChildren(BuildContext context) {
    setState(() {
      if (children > 0) {
        children--;
      }
    });
  }

  Future<void> _checkOutDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (d != null) {
      setState(() {
        checkOut = DateTime(d.year, d.month, d.day, 11, 0, 0);
        checkOutFormat = DateFormat('dd-MM-yyyy').format(checkOut);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final foundRoomProvider = Provider.of<FoundRoomServices>(context);
    facilitiesCollection = facilityService.getFacilities();
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(Strings.darkTurquoise),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Step 1',
            style: TextStyle(color: Color(Strings.darkTurquoise)),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepProgressIndicator(
                  totalSteps: 3,
                  currentStep: 1,
                  size: 13,
                  selectedColor: Color(Strings.darkTurquoise),
                  unselectedColor: Color(Strings.lightBlue),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 8, top: 15),
                      child: Text(
                        'CHECK-IN',
                        style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, bottom: 8, top: 15),
                      child: Text(
                        'CHECK-OUT',
                        style: TextStyle(
                            color: Color(Strings.darkTurquoise),
                            fontSize: mediaQuery.width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    size: mediaQuery.width * 0.05,
                                    color: Color(Strings.orange),
                                  ),
                                  tooltip: 'Tap to open date picker',
                                  onPressed: () {
                                    _checkInDate(context);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 8, top: 10, right: 20),
                                  child: Text(checkInFormat,
                                      style: TextStyle(
                                          fontSize: mediaQuery.width * 0.04,
                                          color: const Color(0xFF49758B))),
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
                                      right: 10, bottom: 8, top: 10, left: 20),
                                  child: Text(checkOutFormat,
                                      style: TextStyle(
                                          fontSize: mediaQuery.width * 0.04,
                                          color: const Color(0xFF49758B))),
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    size: mediaQuery.width * 0.05,
                                    color: const Color(0xFFF0972D),
                                  ),
                                  tooltip: 'Tap to open date picker',
                                  onPressed: () {
                                    _checkOutDate(context);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                if (foundRoomProvider.errorMessage != "")
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.amberAccent,
                    child: ListTile(
                      title: Text(
                        foundRoomProvider.errorMessage,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      leading: const Icon(Icons.error),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => foundRoomProvider.setMessage(""),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 8, top: 15),
                  child: Text(
                    'GUESTS',
                    style: TextStyle(
                        color: const Color(0xFF124559),
                        fontSize: mediaQuery.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 8, top: 10),
                                          child: Text('ADULTS',
                                              style: TextStyle(
                                                  fontSize:
                                                      mediaQuery.width * 0.030,
                                                  color:
                                                      const Color(0xFF333333))),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outlined,
                                              size: 20,
                                              color: Color(0xFFF0972D),
                                            ),
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              decrementAdults(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(adults.toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      mediaQuery.width * 0.04,
                                                  color:
                                                      const Color(0xFF49758B))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outlined,
                                              size: 20,
                                              color: Color(0xFFF0972D),
                                            ),
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              incrementAdults(context);
                                            },
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
                                              left: 10, bottom: 8, top: 10),
                                          child: Text('CHILDREN',
                                              style: TextStyle(
                                                  fontSize:
                                                      mediaQuery.width * 0.030,
                                                  color:
                                                      const Color(0xFF333333))),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outlined,
                                              size: 20,
                                              color: Color(0xFFF0972D),
                                            ),
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              decrementChildren(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(children.toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      mediaQuery.width * 0.04,
                                                  color:
                                                      const Color(0xFF49758B))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outlined,
                                              size: 20,
                                              color: Color(0xFFF0972D),
                                            ),
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              incrementChildren(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                      ),
                      child: Text(
                        "Rooms",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(Strings.darkTurquoise),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 8, top: 10),
                                          child: Text('Rooms',
                                              style: TextStyle(
                                                  fontSize:
                                                      mediaQuery.width * 0.030,
                                                  color:
                                                      const Color(0xFF333333))),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outlined,
                                              size: 20,
                                              color: Color(0xFFF0972D),
                                            ),
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              decrementRooms(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(rooms.toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      mediaQuery.width * 0.04,
                                                  color:
                                                      const Color(0xFF49758B))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outlined,
                                              size: 20,
                                              color: Color(0xFFF0972D),
                                            ),
                                            tooltip: 'Tap to open date picker',
                                            onPressed: () {
                                              incrementRooms(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 8, top: 15),
                  child: Text(
                    'SPECIAL FACILITIES',
                    style: TextStyle(
                        color: const Color(0xFF124559),
                        fontSize: mediaQuery.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.beach_access,
                                    size: 18,
                                    color: Color(0xFFF0972D),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.bedroom_baby,
                                    size: 18,
                                    color: Color(0xFFF0972D),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: SizedBox(
                                      width: mediaQuery.width * 0.4,
                                      child: ElevatedButton(
                                        child: const Text(
                                          'Choose...',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        onPressed: () =>
                                            _showMultipleChoiceDialog(context),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.dry_cleaning,
                                    size: 18,
                                    color: Color(0xFFF0972D),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.fitness_center,
                                    size: 18,
                                    color: Color(0xFFF0972D),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, bottom: 5, top: 10),
                      child: Text(
                        "OTHER DETAILS",
                        style: TextStyle(
                            color: const Color(0xFF124559),
                            fontSize: mediaQuery.width * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 5, top: 10, right: 20),
                      child: TextField(
                        controller: _otherDetailsController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        await foundRoomProvider.checkData(checkIn, checkOut,
                            adults, children, rooms, selectedSpecialFacilities);

                        if (foundRoomProvider.errorMessage == "") {
                          List<RoomModel> rooms = foundRoomProvider.getRooms();
                          if (rooms.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PossibleRooms(
                                      checkInDate: checkIn,
                                      checkOutDate: checkOut,
                                      adults: adults,
                                      children: children,
                                      selectedSpecialFacilities:
                                          selectedSpecialFacilities,
                                      foundedRooms: rooms,
                                      name: name,
                                      otherDetails:
                                          _otherDetailsController.text,
                                      isStaff: false,
                                      email: email),
                                ));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotFoundRoom()));
                          }
                        }
                      },
                      height: 40,
                      minWidth: foundRoomProvider.isLoading ? null : 200,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: foundRoomProvider.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Find a room",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
