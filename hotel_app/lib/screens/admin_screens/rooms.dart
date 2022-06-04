import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/room_model.dart';
import 'package:first_app_flutter/screens/services/rooms_service.dart';
import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'about_room.dart';
import 'add_room.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);
  @override
  _Rooms createState() => _Rooms();
}

class _Rooms extends State<Rooms> {
  final ScrollController _controller = ScrollController();
  RoomsService roomsService = RoomsService();
  List<RoomModel> roomsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    roomsService = Provider.of<RoomsService>(context);
    roomsList = [];
    roomsList = roomsService.getRooms();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF124559), //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Strings.rooms,
          style: const TextStyle(color: Color(0xFF124559)),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.add_circled,
              size: 30,
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddRoom(),
                ),
              )
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            itemCount: roomsList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                elevation: 6,
                shadowColor: const Color(0xFF124559),
                child: InkWell(
                    onTap: () {
                      RoomModel currentRoom = RoomModel(
                          number: roomsList[index].number,
                          cost: roomsList[index].cost,
                          maxGuests: roomsList[index].maxGuests,
                          free: roomsList[index].free,
                          idUser: roomsList[index].idUser,
                          interval: roomsList[index].interval,
                          facilities:
                              roomsList[index].facilities.cast<String>());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutRoom(
                            roomModel: currentRoom,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/room_background.jpg"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                color: const Color(0xFF124559),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 7, top: 5, bottom: 5),
                                  child: Text(
                                    Strings.room + roomsList[index].number,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, top: 3, bottom: 3, right: 3),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.euro,
                                            color: Color(0xFF124559),
                                            size: 23.0,
                                          ),
                                          Text(
                                            roomsList[index].cost.toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF124559),
                                            ),
                                          ),
                                          Text(
                                            Strings.night,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF124559),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (roomsList[index].free == true)
                                Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Card(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          Strings.freeCapital,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                              if (roomsList[index].free == false)
                                Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Card(
                                      color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          Strings.occupiedCapital,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                            ],
                          ),
                          if (roomsList[index].idUser.toString() !=
                              Strings.none)
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 4, bottom: 4),
                                        child: Text(
                                          roomsList[index].idUser,
                                          style: TextStyle(
                                            fontSize: mediaQuery.width * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF124559),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Icon(
                                          Icons.horizontal_rule_rounded,
                                          color: Color(0xFF124559),
                                          size: 40.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7, top: 7, bottom: 4),
                                        child: Text(
                                          roomsList[index].interval,
                                          style: TextStyle(
                                            fontSize: mediaQuery.width * 0.04,
                                            color: const Color(0xFF124559),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
