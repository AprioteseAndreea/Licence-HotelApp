import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
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
                Card(
                    margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    elevation: 6,
                    shadowColor: Color(Strings.darkTurquoise),
                    child: Container(
                      height: 145,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/hotel_details_rooms.jpg"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (super.widget.roomModel.free.toString() == 'true')
                            Padding(
                                padding: const EdgeInsets.all(2),
                                child: Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      Strings.free,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          if (super.widget.roomModel.free.toString() == 'false')
                            Padding(
                                padding: const EdgeInsets.all(2),
                                child: Card(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      Strings.occupied,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    Strings.roomsInformation + super.widget.roomModel.number,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(Strings.darkTurquoise),
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.confirmation_number,
                                color: Color(Strings.darkTurquoise)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              Strings.room,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Strings.orange),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              super.widget.roomModel.number,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(Strings.darkTurquoise),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people,
                                color: Color(Strings.darkTurquoise)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              Strings.maxGuests,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Strings.orange),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              super.widget.roomModel.maxGuests,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(Strings.darkTurquoise),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.euro,
                                color: Color(Strings.darkTurquoise)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              Strings.price,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(Strings.orange),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              super.widget.roomModel.cost,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(Strings.darkTurquoise),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13, top: 10, bottom: 10),
                      child: Text(
                        Strings.facilities,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(Strings.darkTurquoise),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, top: 5, bottom: 10),
                  child: RichText(
                    text: TextSpan(children: <InlineSpan>[
                      for (var f in super.widget.roomModel.facilities)
                        TextSpan(
                            text: ' • $f',
                            style: TextStyle(
                                color: Color(Strings.darkTurquoise),
                                fontSize: 14,
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
                            size: 18.0, color: Color(Strings.orange)),
                        tagPadding: const EdgeInsets.all(6.0)),
                    onTag: (tag) {
                      super.widget.roomModel.facilities.add(tag);
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
