import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final double? textSize;
  final double? height;

  const MyButton(
      {Key? key, this.text, this.iconData, this.textSize, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: const Color.fromRGBO(240, 151, 45, 1.0),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text!,
            style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
