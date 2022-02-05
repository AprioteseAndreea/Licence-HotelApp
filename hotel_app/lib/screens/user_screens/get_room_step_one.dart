import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/screens/services/found_room_service.dart';
import 'package:first_app_flutter/screens/user_screens/not_found_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'get_room_step_two.dart';
import 'notifiers.dart';

class GetRoom extends StatefulWidget {
  const GetRoom({Key? key}) : super(key: key);
  @override
  _GetRoom createState() => _GetRoom();
}

class _GetRoom extends State<GetRoom> {
  TextEditingController nameController = TextEditingController();

  late String _checkInDay = DateTime.now().day.toString();
  late String _checkInMonth = DateFormat.MMMM().format(DateTime.now());
  late String _checkInYear = DateTime.now().year.toString();
  late DateTime checkIn = DateTime.now();
  late DateTime checkOut = DateTime.now();
  late String checkInFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late String checkOutFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());

  late String _checkOutDay = DateTime.now().day.toString();
  late String _checkOutMonth = DateFormat.MMMM().format(DateTime.now());
  late String _checkOutYear = DateTime.now().year.toString();
  int adults = 1;
  int children = 0;

  late String day = '';

  List<FacilityModel> facilitiesCollection = [];
  List<FacilityModel> selectedSpecialFacilities = [];
  late FacilityService facilityService = FacilityService();
  @override
  void initState() {
    facilitiesCollection = facilityService.getFacilities();
    nameController.text = "";
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
        checkIn = d;
        checkInFormat = DateFormat('dd-MM-yyyy').format(checkIn);

        _checkInDay = d.day.toString();
        _checkInMonth = DateFormat.MMMM().format(d);
        _checkInYear = d.year.toString();
      });
    }
  }

  incrementAdults(BuildContext context) {
    setState(() {
      if (adults < 5) {
        adults++;
      }
    });
  }

  decrementAdults(BuildContext context) {
    setState(() {
      if (adults > 1) {
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
        checkOut = d;
        checkOutFormat = DateFormat('dd-MM-yyyy').format(checkOut);
        _checkOutDay = d.day.toString();
        _checkOutMonth = DateFormat.MMMM().format(d);
        _checkOutYear = d.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final foundRoomProvider = Provider.of<FoundRoomServices>(context);
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
                  currentStep: 1,
                  size: 13,
                  selectedColor: Color(0xFF124559),
                  unselectedColor: Color(0xFF72B0D4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 8, top: 15),
                      child: Text(
                        'CHECK-IN',
                        style: TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, bottom: 8, top: 15),
                      child: Text(
                        'CHECK-OUT',
                        style: TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 12,
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
                                  icon: const Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    size: 18,
                                    color: Color(0xFFF0972D),
                                  ),
                                  tooltip: 'Tap to open date picker',
                                  onPressed: () {
                                    _checkInDate(context);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 8, top: 10, right: 10),
                                  child: Text(checkInFormat,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF49758B))),
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
                                      right: 10, bottom: 8, top: 10, left: 10),
                                  child: Text(checkOutFormat,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF49758B))),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    size: 18,
                                    color: Color(0xFFF0972D),
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
                      title: Text(foundRoomProvider.errorMessage),
                      leading: const Icon(Icons.error),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => foundRoomProvider.setMessage(""),
                      ),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 8, top: 15),
                  child: Text(
                    'GUESTS',
                    style: TextStyle(
                        color: Color(0xFF124559),
                        fontSize: 12,
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
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 8, top: 10),
                                          child: Text('ADULTS',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF333333))),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
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
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Color(0xFF49758B))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
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
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 8, top: 10),
                                          child: Text('CHILDREN',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFF333333))),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
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
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Color(0xFF49758B))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2),
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
                const Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 8, top: 15),
                  child: Text(
                    'SPECIAL FACILITIES',
                    style: TextStyle(
                        color: Color(0xFF124559),
                        fontSize: 12,
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
                                      width: 100,
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
                // const Padding(
                //   padding: EdgeInsets.only(left: 15, bottom: 8, top: 15),
                //   child: Text(
                //     'NAME',
                //     style: TextStyle(
                //         color: Color(0xFF124559),
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 30, right: 30),
                //   child: TextFormField(
                //     controller: nameController,
                //     validator: (val) =>
                //         val!.isNotEmpty ? null : "Please enter your full name",
                //     decoration: InputDecoration(
                //       hintText: "Full Name",
                //       prefixIcon: const Icon(
                //         Icons.person,
                //         color: Color(0xFF124559),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5, top: 10),
                      child: Text(
                        "OTHER DETAILS",
                        style: TextStyle(
                            color: Color(0xFF124559),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, bottom: 5, top: 10, right: 20),
                      child: TextField(
                        // controller: nameController,
                        decoration: InputDecoration(
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
                            adults, children, selectedSpecialFacilities);

                        if (foundRoomProvider.errorMessage == "") {
                          List<RoomModel> rooms = foundRoomProvider.getRooms();
                          if (rooms.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetRoomS2(
                                    checkInDate: checkIn,
                                    checkOutDate: checkOut,
                                    adults: adults,
                                    children: children,
                                    selectedSpecialFacilities:
                                        selectedSpecialFacilities,
                                    room: rooms[0],
                                    name: nameController.text,
                                  ),
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
