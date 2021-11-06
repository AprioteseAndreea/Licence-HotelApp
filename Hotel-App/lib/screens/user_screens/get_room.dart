import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late String _checkIn = 'Check-in date';
  late String _checkOut = 'Check-out date';
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
        _checkIn = DateFormat.yMMMMd("en_US").format(d);
      });
    }
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
        _checkOut = DateFormat.yMMMMd("en_US").format(d);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grand Hotel'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
                  child: Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF124559),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Check-in',
                            style: TextStyle(
                              color: Color(0xFFF0972D),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF124559),
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Text(_checkIn,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xFF124559))),
                                  onTap: () {
                                    _checkInDate(context);
                                  },
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Check-out',
                            style: TextStyle(
                              color: Color(0xFFF0972D),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF124559),
                                width: 1,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Text(_checkOut,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xFF124559))),
                                  onTap: () {
                                    _checkOutDate(context);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_today,
                                      size: 18, color: Color(0xFFF0972D)),
                                  tooltip: 'Tap to open date picker',
                                  onPressed: () {
                                    _checkOutDate(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
                  child: Text(
                    "Guests",
                    style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF124559),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Adults',
                            style: TextStyle(
                              color: Color(0xFFF0972D),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _adultsNumberValue,
                          //elevation: 5,
                          style: const TextStyle(color: Color(0xFF124559)),
                          iconEnabledColor: const Color(0xFF124559),
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style:
                                    const TextStyle(color: Color(0xFF124559)),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            "Number of adults",
                            style: TextStyle(
                                color: Color(0xFF124559),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _adultsNumberValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Children',
                            style: TextStyle(
                              color: Color(0xFFF0972D),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _childrenNumberValue,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: const Color(0xFF124559),
                          items: <String>[
                            '0',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style:
                                    const TextStyle(color: Color(0xFF124559)),
                              ),
                            );
                          }).toList(),
                          hint: const Text(
                            "Number of children",
                            style: TextStyle(
                                color: Color(0xFF124559),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _childrenNumberValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
                      child: Text(
                        "Rooms",
                        style: TextStyle(
                            fontSize: 23,
                            color: Color(0xFF124559),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _roomsNumberValue,
                        //elevation: 5,
                        style: const TextStyle(color: Color(0xFF124559)),
                        iconEnabledColor: const Color(0xFF124559),
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Color(0xFF124559)),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Number of rooms",
                          style: TextStyle(
                              color: Color(0xFF124559),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _roomsNumberValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
                      child: Text(
                        "Special facilities",
                        style: TextStyle(
                            fontSize: 23,
                            color: Color(0xFF124559),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          child: const Text('Choose...'),
                          onPressed: () => _showMultipleChoiceDialog(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5, top: 20),
                      child: Text(
                        "Others details",
                        style: TextStyle(
                            fontSize: 23,
                            color: Color(0xFF124559),
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
                        maxLines: 3,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
