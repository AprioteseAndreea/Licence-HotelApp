import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AboutRoom extends StatefulWidget {
  final RoomModel roomModel;
  const AboutRoom({Key? key, required this.roomModel}) : super(key: key);
  @override
  _AboutRoom createState() => _AboutRoom();
}

class _AboutRoom extends State<AboutRoom> {
  late List<String> facilities = [];
  late List<RoomModel> rooms = [];

  late TextEditingController _numberController;
  late TextEditingController _maxGuestsController;
  late TextEditingController _priceController;
  late RoomsService roomsService;
  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _maxGuestsController = TextEditingController();
    _priceController = TextEditingController();
    _numberController.text = super.widget.roomModel.number;
    _maxGuestsController.text = super.widget.roomModel.maxGuests;
    _priceController.text = super.widget.roomModel.cost;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const Text("Ok"),
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
      title: const Text("Delete room"),
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
    rooms = roomsService.getRooms();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('ROOM ${super.widget.roomModel.number}',
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
                Card(
                    margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    elevation: 6,
                    shadowColor: const Color(0xFF124559),
                    child: Container(
                      height: 125,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/hotel_details_rooms.jpg"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.confirmation_number,
                          color: Color(0xFF124559)),
                      border: OutlineInputBorder(),
                      hintText: 'Rooms\' number',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    controller: _maxGuestsController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people, color: Color(0xFF124559)),
                      border: OutlineInputBorder(),
                      hintText: 'Max guests',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.euro, color: Color(0xFF124559)),
                      border: OutlineInputBorder(),
                      hintText: 'Price',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 13, top: 10, bottom: 10),
                      child: Text(
                        'FACILITIES',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF124559),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var f in super.widget.roomModel.facilities)
                        Text(
                          '$f, ',
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              color: Color(0xFF124559)),
                        )
                    ],
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
                          color: const Color(0xFF124559),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        tagCancelIcon: const Icon(Icons.cancel,
                            size: 18.0, color: Color(0xFFF0972D)),
                        tagPadding: const EdgeInsets.all(6.0)),
                    onTag: (tag) {
                      super.widget.roomModel.facilities.add(tag);
                    },
                    textFieldStyler: TextFieldStyler(
                      cursorColor: const Color(0xFF124559),
                    ),
                    onDelete: (String tag) {
                      super.widget.roomModel.facilities.remove(tag);
                    },
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    super.widget.roomModel.maxGuests =
                        _maxGuestsController.text;
                    super.widget.roomModel.cost = _priceController.text;

                    roomsService.updateRoomInFirebase(super.widget.roomModel);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Rooms(),
                        ),
                        ModalRoute.withName('/'));
                  },
                  height: 40,
                  color: const Color(0xFFF0972D),
                  textColor: const Color(0xFF124559),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Update room",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
