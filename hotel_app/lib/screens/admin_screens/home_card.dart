import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  String title;
  String imageUrl;
  GestureTapCallback? onPressed;

  HomeCard(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Color(Strings.darkTurquoise),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: mediaQuery.height * 0.13,
              width: mediaQuery.width * 0.33,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: mediaQuery.height * 0.055,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color(0xFFF0972D),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
