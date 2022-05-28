import 'package:email_validator/email_validator.dart';
import 'package:first_app_flutter/models/extra_facility_model.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/services/facilities_service.dart';
import 'package:first_app_flutter/screens/services/found_room_service.dart';
import 'package:first_app_flutter/screens/staff_screens/book_staff_two.dart';
import 'package:first_app_flutter/screens/user_screens/not_found_room.dart';
import 'package:first_app_flutter/screens/user_screens/notifiers.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BookStaff extends StatefulWidget {
  const BookStaff({Key? key}) : super(key: key);
  @override
  _BookStaff createState() => _BookStaff();
}

class _BookStaff extends State<BookStaff> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  late DateTime checkIn = DateTime.now();
  late DateTime checkOut = DateTime.now();

  late String day = '', name = '';
  late String checkInFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late String checkOutFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final _formkey = GlobalKey<FormState>();

  int adults = 1;
  int children = 0;

  List<FacilityModel> facilitiesCollection = [];
  List<FacilityModel> selectedSpecialFacilities = [];

  late FacilityService facilityService = FacilityService();

  @override
  void initState() {
    facilitiesCollection = facilityService.getFacilities();
    _nameController = TextEditingController();
    _emailController = TextEditingController();

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
                Form(
                    key: _formkey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: const Color(0xFFFFFFFF),
                          elevation: 10,
                          child: SizedBox(
                            width: mediaQuery.width * 0.95,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        Strings.fullName,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(Strings.darkTurquoise),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _nameController,
                                          validator: (val) => val!.isNotEmpty
                                              ? null
                                              : 'Please enter client\'s name',
                                          decoration: InputDecoration(
                                              hintText: 'Enter client\'s name',
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
                                              prefixIcon: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Strings.darkTurquoise),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Color(Strings
                                                            .darkTurquoise))),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Color(Strings.orange),
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              )),
                                          onChanged: (value) {
                                            name = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                      ),
                                      child: Text(
                                        "E-mail",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(Strings.darkTurquoise),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _emailController,
                                          validator: (value) => EmailValidator
                                                  .validate(value)
                                              ? null
                                              : 'Please enter client\'s email',
                                          decoration: InputDecoration(
                                              hintText: 'Enter client\'s email',
                                              hintStyle:
                                                  const TextStyle(fontSize: 15),
                                              prefixIcon: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        Strings.darkTurquoise),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Color(Strings
                                                            .darkTurquoise))),
                                                child: Icon(
                                                  Icons.mail,
                                                  color: Color(Strings.orange),
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              )),
                                          onChanged: (value) {
                                            name = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 8, top: 15),
                                      child: Text(
                                        'Check-in',
                                        style: TextStyle(
                                            color: const Color(0xFF124559),
                                            fontSize: mediaQuery.width * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, bottom: 8, top: 15),
                                      child: Text(
                                        'Check-out',
                                        style: TextStyle(
                                            color: const Color(0xFF124559),
                                            fontSize: mediaQuery.width * 0.04,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        child: Row(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    CupertinoIcons
                                                        .calendar_badge_plus,
                                                    size:
                                                        mediaQuery.width * 0.05,
                                                    color:
                                                        const Color(0xFFF0972D),
                                                  ),
                                                  tooltip:
                                                      'Tap to open date picker',
                                                  onPressed: () {
                                                    _checkInDate(context);
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          bottom: 8,
                                                          top: 10,
                                                          right: 20),
                                                  child: Text(checkInFormat,
                                                      style: TextStyle(
                                                          fontSize:
                                                              mediaQuery.width *
                                                                  0.04,
                                                          color: const Color(
                                                              0xFF49758B))),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10,
                                                          bottom: 8,
                                                          top: 10,
                                                          left: 20),
                                                  child: Text(checkOutFormat,
                                                      style: TextStyle(
                                                          fontSize:
                                                              mediaQuery.width *
                                                                  0.04,
                                                          color: const Color(
                                                              0xFF49758B))),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    CupertinoIcons
                                                        .calendar_badge_plus,
                                                    size:
                                                        mediaQuery.width * 0.05,
                                                    color:
                                                        const Color(0xFFF0972D),
                                                  ),
                                                  tooltip:
                                                      'Tap to open date picker',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
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
                                        onPressed: () =>
                                            foundRoomProvider.setMessage(""),
                                      ),
                                    ),
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
                                        Strings.guests,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(Strings.darkTurquoise),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Card(
                                                child: Row(
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  bottom: 8,
                                                                  top: 10),
                                                          child: Text('Adults',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      mediaQuery
                                                                              .width *
                                                                          0.030,
                                                                  color: const Color(
                                                                      0xFF333333))),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  right: 0),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .remove_circle_outlined,
                                                              size: 20,
                                                              color: Color(
                                                                  0xFFF0972D),
                                                            ),
                                                            tooltip:
                                                                'Tap to open date picker',
                                                            onPressed: () {
                                                              decrementAdults(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0),
                                                          child: Text(
                                                              adults.toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      mediaQuery
                                                                              .width *
                                                                          0.04,
                                                                  color: const Color(
                                                                      0xFF49758B))),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  right: 0),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .add_circle_outlined,
                                                              size: 20,
                                                              color: Color(
                                                                  0xFFF0972D),
                                                            ),
                                                            tooltip:
                                                                'Tap to open date picker',
                                                            onPressed: () {
                                                              incrementAdults(
                                                                  context);
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  bottom: 8,
                                                                  top: 10),
                                                          child: Text(
                                                              'Children',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      mediaQuery
                                                                              .width *
                                                                          0.030,
                                                                  color: const Color(
                                                                      0xFF333333))),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  right: 0),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .remove_circle_outlined,
                                                              size: 20,
                                                              color: Color(
                                                                  0xFFF0972D),
                                                            ),
                                                            tooltip:
                                                                'Tap to open date picker',
                                                            onPressed: () {
                                                              decrementChildren(
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0),
                                                          child: Text(
                                                              children
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      mediaQuery
                                                                              .width *
                                                                          0.04,
                                                                  color: const Color(
                                                                      0xFF49758B))),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0,
                                                                  right: 0),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .add_circle_outlined,
                                                              size: 20,
                                                              color: Color(
                                                                  0xFFF0972D),
                                                            ),
                                                            tooltip:
                                                                'Tap to open date picker',
                                                            onPressed: () {
                                                              incrementChildren(
                                                                  context);
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
                                        'Special facilities',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(Strings.darkTurquoise),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: SizedBox(
                                                      width: mediaQuery.width *
                                                          0.4,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                          'Choose...',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        onPressed: () =>
                                                            _showMultipleChoiceDialog(
                                                                context),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                      onPressed: () async {
                                        await foundRoomProvider.checkData(
                                            checkIn,
                                            checkOut,
                                            adults,
                                            children,
                                            selectedSpecialFacilities);

                                        if (foundRoomProvider.errorMessage ==
                                            "") {
                                          List<RoomModel> rooms =
                                              foundRoomProvider.getRooms();
                                          if (rooms.isNotEmpty) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookStaffTwo(
                                                    checkInDate: checkIn,
                                                    checkOutDate: checkOut,
                                                    adults: adults,
                                                    children: children,
                                                    selectedSpecialFacilities:
                                                        selectedSpecialFacilities,
                                                    room: rooms[0],
                                                    name: _nameController.text,
                                                    email:
                                                        _emailController.text,
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
                                      minWidth: foundRoomProvider.isLoading
                                          ? null
                                          : 200,
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
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
