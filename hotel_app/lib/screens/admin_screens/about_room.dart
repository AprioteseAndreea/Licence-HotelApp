import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class AboutRoom extends StatefulWidget {
  final RoomModel roomModel;
  const AboutRoom({Key? key, required this.roomModel}) : super(key: key);
  @override
  _AboutRoom createState() => _AboutRoom();
}

class _AboutRoom extends State<AboutRoom> {
  late List<String> facilities = [];
  late List<RoomModel> rooms = [];
  final _formkey = GlobalKey<FormState>();
  late String _selectedStatus;
  late String priceController;
  late String maxGuestsController;

  late TextEditingController _numberController;
  late TextEditingController _maxGuestsController;
  late TextEditingController _priceController;
  late RoomsService roomsService;
  @override
  void initState() {
    _numberController = TextEditingController();
    _maxGuestsController = TextEditingController();
    _priceController = TextEditingController();
    _numberController.text = super.widget.roomModel.number;
    _maxGuestsController.text = super.widget.roomModel.maxGuests;
    _priceController.text = super.widget.roomModel.cost;
    _selectedStatus =
        (super.widget.roomModel.free == true ? Strings.free : Strings.occupied);
    priceController = super.widget.roomModel.cost;
    maxGuestsController = super.widget.roomModel.maxGuests;

    super.initState();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(Strings.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: Text(Strings.ok),
      onPressed: () {
        roomsService.deleteRoomInFirebase(super.widget.roomModel);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Rooms(),
            ),
            ModalRoute.withName('/'));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Strings.deleteRoom),
      content:
          Text("Do you want to delete room ${super.widget.roomModel.number}?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    roomsService = Provider.of<RoomsService>(context);
    Size mediaQuery = MediaQuery.of(context).size;

    rooms = roomsService.getRooms();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(Strings.roomDetails,
              style: const TextStyle(color: Color(0xFF124559))),
          actions: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.delete,
                size: 25,
              ),
              onPressed: () => {showAlertDialog(context)},
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Form(
                    key: _formkey,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: const Color(0xFFFFFFFF),
                      elevation: 10,
                      child: SizedBox(
                        width: mediaQuery.width + 0.9,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      color: Color(Strings.darkTurquoise),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.bed,
                                              color: Color(Strings.orange),
                                            ),
                                            Text(
                                              " " +
                                                  Strings.room +
                                                  " " +
                                                  super.widget.roomModel.number,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            Row(
                              children: [
                                sectionTitle(Strings.status),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 15,
                                    right: 10,
                                  ),
                                  child: CupertinoRadioChoice(
                                    choices: Strings.statusMap,
                                    onChange: onStatusSelected,
                                    initialKeyValue: _selectedStatus,
                                    selectedColor: Color(Strings.darkTurquoise),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                sectionTitle(Strings.price),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.euro,
                                            color: Color(Strings.orange)),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          priceController,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color(Strings.darkTurquoise),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Color(Strings.orange),
                                      onPressed: () {
                                        _showMyDialog(context,
                                            Strings.modifyPriceForRoom);
                                      },
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                sectionTitle(Strings.maxGuests),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.people,
                                          color: Color(Strings.orange)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        maxGuestsController,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(Strings.darkTurquoise),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Color(Strings.orange),
                                    onPressed: () {
                                      _showMyDialog(context,
                                          Strings.modifyMaxGuestsForRoom);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                sectionTitle(Strings.facilities),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 13, top: 5, bottom: 10),
                              child: RichText(
                                text: TextSpan(children: <InlineSpan>[
                                  for (var f
                                      in super.widget.roomModel.facilities)
                                    TextSpan(
                                        text: ' • $f',
                                        style: TextStyle(
                                            color: Color(Strings.darkTurquoise),
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic)),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFieldTags(
                                tagsStyler: TagsStyler(
                                    tagTextStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    tagDecoration: BoxDecoration(
                                      color: Color(Strings.darkTurquoise),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    tagCancelIcon: Icon(Icons.cancel,
                                        size: 18.0,
                                        color: Color(Strings.orange)),
                                    tagPadding: const EdgeInsets.all(6.0)),
                                onTag: (tag) {
                                  if (!super
                                      .widget
                                      .roomModel
                                      .facilities
                                      .contains(tag)) {
                                    super.widget.roomModel.facilities.add(tag);
                                  }
                                },
                                textFieldStyler: TextFieldStyler(
                                  cursorColor: Color(Strings.darkTurquoise),
                                ),
                                onDelete: (String tag) {
                                  super.widget.roomModel.facilities.remove(tag);
                                },
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                super.widget.roomModel.maxGuests =
                                    maxGuestsController;
                                super.widget.roomModel.cost = priceController;

                                roomsService.updateRoomInFirebase(
                                    super.widget.roomModel);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Rooms(),
                                    ),
                                    ModalRoute.withName('/'));
                              },
                              height: 40,
                              color: Color(Strings.orange),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                Strings.updateRoom,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _showMyDialog(BuildContext context, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title + super.widget.roomModel.number),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                title == Strings.modifyPriceForRoom
                    ? const Text("New price:")
                    : const Text("New max guests:"),
                title == Strings.modifyPriceForRoom
                    ? WheelChooser.integer(
                        listWidth: 60,
                        onValueChanged: (i) => {
                          setState(() {
                            priceController = i.toString();
                          })
                        },
                        maxValue: 300,
                        minValue: 80,
                        step: 5,
                        initValue: int.parse(priceController),
                        unSelectTextStyle: const TextStyle(color: Colors.grey),
                        selectTextStyle:
                            TextStyle(color: Color(Strings.darkTurquoise)),
                        horizontal: true,
                      )
                    : WheelChooser.integer(
                        listWidth: 60,
                        onValueChanged: (i) => {
                          setState(() {
                            maxGuestsController = i.toString();
                          })
                        },
                        maxValue: 6,
                        minValue: 1,
                        step: 1,
                        initValue: int.parse(maxGuestsController),
                        unSelectTextStyle: const TextStyle(color: Colors.grey),
                        selectTextStyle:
                            TextStyle(color: Color(Strings.darkTurquoise)),
                        horizontal: true,
                      )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onStatusSelected(String statusKey) {
    setState(() {
      _selectedStatus = statusKey;
      if (_selectedStatus == Strings.free) {
        super.widget.roomModel.idUser = Strings.none;
        super.widget.roomModel.interval = Strings.none;
        super.widget.roomModel.free = true;
      }
    });
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        right: 10,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color(Strings.darkTurquoise),
        ),
      ),
    );
  }
}

class TagModel {
  String id;
  String title;

  TagModel({
    required this.id,
    required this.title,
  });
}
