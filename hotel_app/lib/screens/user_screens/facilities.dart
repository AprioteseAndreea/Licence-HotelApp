import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({Key? key}) : super(key: key);

  @override
  _FacilitiesScreen createState() => _FacilitiesScreen();
}

class _FacilitiesScreen extends State<FacilitiesScreen> {
  List<String> facilities = [];

  @override
  void initState() {
    super.initState();

    facilities.add("assets/images/spa.png");
    facilities.add("assets/images/restaurant.png");
    facilities.add("assets/images/pool.png");
    facilities.add("assets/images/babysitter.png");
    facilities.add("assets/images/car.png");
    facilities.add("assets/images/pet.png");
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
          'Facilities',
          style: TextStyle(color: Color(0xFF124559)),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.spa,
                    color: Color(Strings.orange),
                    size: mediaQuery.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Spa',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Text(
                      "      After a full day of exploring, a long flight or a hard day at work, relaxing and unwind using our spa facilities. The spa is a private room containing Sauna, Jacuzzi, changing facilities, toilet and luxury showers.  Please note there is a charge for using this facility and we require a minimum of one hours notice.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 15,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Program: ',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'M-F: 10:00 - 22:00',
                  style: TextStyle(
                    color: Color(Strings.darkTurquoise),
                    fontSize: mediaQuery.width * 0.040,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Conditions: ',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      ' - When booking it is reserved  exclusively for you and charged on an hourly basis.',
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    ' - Price: 22.00\$ per hour',
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: mediaQuery.width * 0.040,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    ' - Upto 4 persons per session',
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: mediaQuery.width * 0.040,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      ' - All children under the age of 16 need to be accompanied by an adult',
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      ' - Please adhere to our Sauna and Jacuzzi safe use guidelines when using this facility.  Displayed in the Spa but please contact us if you would like a copy prior to booking this facility.',
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.restaurant,
                    color: Color(Strings.orange),
                    size: mediaQuery.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Restaurant',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Text(
                      "      Our newly refurbished and extended restaurant has been designed with a warm and contemporary feel, carefully designed to enable space yet intimacy.  Again like our lounge bar offering panoramic view of Stanley harbour. However, the most important aspect of any restaurant is the quality of food and service, and we are justifiably proud of both. \n     Our menu is based on the principles of using the high quality raw local ingredients, along with the best of ingredients imported from around the world, freshly cooked and presented by our head chef Matt Clarke and his team with care and attention.There is a wide selection to choose from, including fresh fish, char-grills, ala’carte selections and special menus.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Program: ',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    ' - Breakfast 7am – 9:30am',
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: mediaQuery.width * 0.040,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    ' - Lunch 12noon – 2:00pm',
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: mediaQuery.width * 0.040,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      ' - Dinner Monday to Thursday 7pm – 9pm  Friday and Saturday 6pm – 9pm',
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.pool,
                    color: Color(Strings.orange),
                    size: mediaQuery.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Pool',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Text(
                      "Grand Hotel’s swimming pool has a perfect ventilation system, strict water quality control, and natural lighting that ensures a relaxing atmosphere. Enjoy swimming at Grand Hotel's indoor pool regardless of the weather.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Details: ',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    ' - Size: 18 m, 3 lanes, Depth 1.2 m',
                    style: TextStyle(
                      color: Color(Strings.darkTurquoise),
                      fontSize: mediaQuery.width * 0.040,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      ' - Guests under 14 years old may enter only when accompanied by an adult',
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      " - Outside food is not permitted in the swimming pool",
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text(
                      "- Shower rooms and personal lockers are available for use",
                      style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.040,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.baby_changing_station,
                    color: Color(Strings.orange),
                    size: mediaQuery.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Babysitter',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Text(
                      "      Whether you would like to meet a friend in the hotel restaurant, enjoy a spa treatment, or attend a conference, Grand Hotel provides a flexible service that can make it happen, even if you are traveling with your children! Our Hotel Babysitters service in London compliments your family’s needs so you can escape the daily routine, enjoy some time alone with your partner, or take care of your business arrangements.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.local_parking,
                    color: Color(Strings.orange),
                    size: mediaQuery.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Car parking',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Text(
                      "      The hotel parking lot has a capacity of 100 parking spaces, so you will no longer have to worry about the parking space and be able to relax without worries when you visit our hotel.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.pets,
                    color: Color(Strings.orange),
                    size: mediaQuery.width * 0.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Pet friendly',
                    style: TextStyle(
                        color: Color(Strings.darkTurquoise),
                        fontSize: mediaQuery.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 10),
                    child: Text(
                      "      Our hotel accepts our guests' pets, providing them with food, bowls of water, outdoor play areas and dog tracks. We've also implemented the concept of \"kitchen for dogs\", with room service menus specially tailored to dogs' palettes - these features will also make our guests more likely to order room service or dine, as their pet may have and a delicious meal.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: mediaQuery.width * 0.040,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
