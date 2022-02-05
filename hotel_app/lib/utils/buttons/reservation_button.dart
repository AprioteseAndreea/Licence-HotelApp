import 'package:flutter/material.dart';

class ReservationButton extends StatelessWidget {
  final String textButton;
  final int color;

  const ReservationButton(
      {Key? key, required this.textButton, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2),
        child: Card(
          color: Color(color),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              textButton,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
