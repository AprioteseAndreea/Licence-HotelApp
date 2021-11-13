import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'notifiers.dart';

class GetRoom extends StatefulWidget {
  const GetRoom({Key? key}) : super(key: key);
  @override
  _GetRoom createState() => _GetRoom();
}

class _GetRoom extends State<GetRoom> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  TextEditingController nameController = TextEditingController();

  late String _checkInDay = '1';
  late String _checkInMonth = 'JANUARY';
  late String _checkInYear = '2021';

  late String _checkOutDay = '1';
  late String _checkOutMonth = 'JANUARY';
  late String _checkOutYear = '2021';
  int guests = 0;
  late String day = '';
  String? _adultsNumberValue;
  String? _childrenNumberValue;
  String? _roomsNumberValue;
  static const List<String> specialFacilities = <String>[
    'kitchen',
    "TV",
    "baby room"
  ];
  List<String> selectedSpecialFacilities = [];
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
                  children: specialFacilities
                      .map((e) => CheckboxListTile(
                            title: Text(e),
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
              child: const Text('Yes'),
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
        _checkInDay = d.day.toString();
        _checkInMonth = DateFormat.MMMM().format(d);
        _checkInYear = d.year.toString();
      });
    }
  }

  incrementGuests(BuildContext context) {
    setState(() {
      if (guests < 5) {
        guests++;
      }
    });
  }

  decrementGuests(BuildContext context) {
    setState(() {
      if (guests > 0) {
        guests--;
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
        _checkOutDay = d.day.toString();
        _checkOutMonth = DateFormat.MMMM().format(d);
        _checkOutYear = d.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, bottom: 8, top: 15),
                          child: Text(
                            'CHECK-IN DATE',
                            style: TextStyle(
                                color: Color(0xFF124559),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, bottom: 8, top: 10),
                                        child: Text(_checkInDay,
                                            style: const TextStyle(
                                                fontSize: 35,
                                                color: Color(0xFF49758B))),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Icon(
                                          Icons.horizontal_rule_rounded,
                                          color: Colors.grey,
                                          size: 40.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _checkInYear,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFF0972D),
                                              ),
                                            ),
                                            Text(
                                              _checkInMonth,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF124559),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.calendar_today,
                                          size: 18,
                                          color: Color(0xFFF0972D),
                                        ),
                                        tooltip: 'Tap to open date picker',
                                        onPressed: () {
                                          _checkInDate(context);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, bottom: 8, top: 15),
                          child: Text(
                            'CHECK-OUT DATE',
                            style: TextStyle(
                                color: Color(0xFF124559),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, bottom: 8, top: 10),
                                        child: Text(_checkOutDay,
                                            style: const TextStyle(
                                                fontSize: 35,
                                                color: Color(0xFF49758B))),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Icon(
                                          Icons.horizontal_rule_rounded,
                                          color: Colors.grey,
                                          size: 40.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _checkOutYear,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFF0972D),
                                              ),
                                            ),
                                            Text(
                                              _checkOutMonth,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF124559),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.calendar_today,
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
                            )),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 8, top: 15),
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
                                              decrementGuests(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(guests.toString(),
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
                                              incrementGuests(context);
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
                                              decrementGuests(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 0),
                                          child: Text(guests.toString(),
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
                                              incrementGuests(context);
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
                                  IconButton(
                                    icon: const Icon(
                                      Icons.beach_access,
                                      size: 18,
                                      color: Color(0xFFF0972D),
                                    ),
                                    tooltip: 'Tap to open date picker',
                                    onPressed: () {
                                      _checkOutDate(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.bedroom_baby,
                                      size: 18,
                                      color: Color(0xFFF0972D),
                                    ),
                                    tooltip: 'Tap to open date picker',
                                    onPressed: () {
                                      _checkOutDate(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.dry_cleaning,
                                      size: 18,
                                      color: Color(0xFFF0972D),
                                    ),
                                    tooltip: 'Tap to open date picker',
                                    onPressed: () {
                                      _checkOutDate(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.fitness_center,
                                      size: 18,
                                      color: Color(0xFFF0972D),
                                    ),
                                    tooltip: 'Tap to open date picker',
                                    onPressed: () {
                                      _checkOutDate(context);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10, top: 5, bottom: 5),
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
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text(
                        'Choose a room',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () => _showMultipleChoiceDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
