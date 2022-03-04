import 'package:flutter/material.dart';

class ReservationButton extends StatelessWidget {
  final String textButton;
  final int color;
  final VoidCallback? onTap;

  const ReservationButton(
      {Key? key,
      required this.textButton,
      required this.color,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: MaterialButton(
        onPressed: onTap,
        height: 45,
        color: Color(color),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          textButton,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
