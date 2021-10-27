import 'dart:ui';

import 'package:flutter/cupertino.dart';

class DrawerPainter extends CustomPainter {
  final Offset? offset;

  DrawerPainter({this.offset});

  double getControlPointX(double width) {
    if (offset!.dx == 0) {
      return width;
    } else {
      return offset!.dx > width ? offset!.dx : width + 75;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(18, 69, 89, 1.0)
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getControlPointX(size.width), offset!.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
