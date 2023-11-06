import 'dart:developer' as dev;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PaintCircle extends CustomPainter {
  Offset findOffset(cx, cy, radius, angleInDegrees) {
    var angleInRadians = angleInDegrees * (pi / 180);

    double x = cx + (radius * cos(angleInRadians));
    double y = cy + (radius * sin(angleInRadians));

    return Offset(x, y);
  }

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;
    Paint innerPaint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [
          const ui.Color.fromARGB(255, 235, 212, 212),
          const ui.Color.fromARGB(255, 204, 82, 38),
        ],
      )
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    Paint outerPaint = Paint()
      ..color = const Color.fromARGB(255, 204, 82, 38)
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    Paint stripePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 180, outerPaint);
    canvas.drawCircle(center, radius, innerPaint);

    getPointsOffsets() {
      int angel = 0;

      for (var i = 0; i < 12; i++) {
        canvas.drawLine(findOffset(center.dx, center.dy, 120, angel),
            findOffset(center.dx, center.dy, radius, angel), stripePaint);

        angel += 30;
      }
    }

    getTextPaint(text, angel) {
      TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 25, height: 0),
          text: '$text');
      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);

      tp.layout();
      dev.log(tp.size.toString());

      Offset offset = findOffset(center.dx, center.dy, radius - 50, angel);
      offset = Offset(
          offset.dx - (tp.size.width / 2), offset.dy - (tp.size.height / 2));
      tp.paint(canvas, offset);
    }

    getPointsOffsets();
    getTextPaint('12', 270);
    getTextPaint('3', 0);
    getTextPaint('6', 90);
    getTextPaint('9', 180);

    Paint secondsPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Paint minutePaint = Paint()
      ..color =  Colors.brown
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Paint hourPaint = Paint()
      ..color = const ui.Color.fromARGB(255, 243, 201, 33)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    int seconds = DateTime.now().second;
    int minute = DateTime.now().minute;
    int hour = DateTime.now().hour;

    canvas.drawLine(
        center,
        findOffset(center.dx, center.dy, radius - 30, seconds * 6 - 90),
        secondsPaint);
    dev.log('sec$seconds');

    canvas.drawLine(
        center,
        findOffset(center.dx, center.dy, radius - 35, minute * 6 - 90),
        minutePaint);
    dev.log('min$minute');

    canvas.drawLine(
        center,
        findOffset(center.dx, center.dy, radius - 50,
            ((hour + minute / 60) * 30) - 90),
        hourPaint);
    dev.log('hours$hour');
  }

  @override
  bool shouldRepaint(PaintCircle oldDelegate) => true;
}
