import 'package:first_app_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class TextFormFieldTitle extends StatelessWidget {
  final String title;

  const TextFormFieldTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              color: Color(Strings.darkTurquoise),
            ),
          ),
        ),
      ],
    );
  }
}
