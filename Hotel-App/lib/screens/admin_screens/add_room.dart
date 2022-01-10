import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/admin_screens/rooms.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({Key? key}) : super(key: key);
  @override
  _AddRoom createState() => _AddRoom();
}

class _AddRoom extends State<AddRoom> {
  late List<String> facilities = [];
  late List<RoomModel> rooms = [];

  late TextEditingController _numberController;
  late TextEditingController _maxGuestsController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _maxGuestsController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final roomsService = Provider.of<RoomsService>(context);
    rooms = roomsService.getRooms();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xFF124559), //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Add new room',
              style: TextStyle(color: Color(0xFF124559))),
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
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Add a new room for your guests',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF124559),
                    ),
                  ),
                ),
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
                      facilities.add(tag);
                    },
                    textFieldStyler: TextFieldStyler(
                      cursorColor: const Color(0xFF124559),
                    ),
                    onDelete: (String tag) {
                      facilities.remove(tag);
                    },
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    RoomModel room = RoomModel(
                        number: _numberController.text,
                        cost: _priceController.text,
                        maxGuests: _maxGuestsController.text,
                        free: true,
                        pending: false,
                        idUser: "none",
                        interval: "none",
                        facilities: facilities);

                    roomsService.addRoomInFirebase(room);
                    if (roomsService.errorMessage == "") {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Rooms(),
                          ),
                          ModalRoute.withName('/'));
                    }
                  },
                  height: 40,
                  color: const Color(0xFFF0972D),
                  textColor: const Color(0xFF124559),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Add room",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (roomsService.errorMessage != "")
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.amberAccent,
                    child: ListTile(
                      title: Text(roomsService.errorMessage),
                      leading: const Icon(Icons.error),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => roomsService.setMessage(""),
                      ),
                    ),
                  )
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
