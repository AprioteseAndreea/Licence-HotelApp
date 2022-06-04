import 'package:flutter/material.dart';
import '../strings.dart';

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
        height: 40,
        color: Color(color),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              textButton,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (textButton == Strings.downloadBill)
              const Icon(
                Icons.download,
                size: 20,
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
