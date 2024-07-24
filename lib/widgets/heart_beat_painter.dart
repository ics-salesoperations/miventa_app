import 'package:flutter/material.dart';

class HeartBeatPainter extends CustomPainter {
  late Paint _paint;
  late Paint _unPaint;
  double progress;
  Color color;
  final bool beat;

  HeartBeatPainter(
      {required this.progress, required this.color, required this.beat}) {
    _paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    _unPaint = Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double rounded = double.parse(progress.toStringAsFixed(3));

    double x = -90.0;
    double y = 25.0;

    if (beat) {
      double x2 = -90 + (rounded <= 0.125 ? (50 * rounded / 0.125) : 50);
      double y2 = 25.0;

      canvas.drawLine(
        Offset(x, y),
        Offset(
          x2,
          y2,
        ),
        _paint,
      );

      x = x2;
      y = y2;
      x2 = -40 +
          (rounded > 0.125
              ? rounded <= 0.25
                  ? (10 * (rounded - 0.125) / 0.125)
                  : 10
              : 10);
      y2 = 25 -
          (rounded > 0.125
              ? rounded <= 0.25
                  ? (15 * (rounded - 0.125) / 0.125)
                  : 15
              : 15);
      canvas.drawLine(
        Offset(
          x, //size.width * progress - size.width,
          y, //size.height * progress - size.height,
        ),
        Offset(
          //-30, //size.width * progress - size.width,
          x2,
          //10, //size.height * progress - size.height,
          y2,
        ),
        rounded > 0.125 ? _paint : _unPaint,
      );

      x = x2;
      y = y2;
      x2 = -30 +
          (rounded > 0.25
              ? rounded <= 0.375
                  ? (10 * (rounded - 0.25) / 0.125)
                  : 10
              : 10);
      y2 = 10 +
          (rounded > 0.25
              ? rounded <= 0.375
                  ? (40 * (rounded - 0.25) / 0.125)
                  : 40
              : 15);

      canvas.drawLine(
        Offset(
          //-30,
          x,
          //10,
          y,
        ),
        Offset(
          //-20,
          x2,
          //50,
          y2,
        ),
        rounded > 0.25 ? _paint : _unPaint,
      );

      x = x2;
      y = y2;
      x2 = -20 +
          (rounded > 0.375
              ? rounded <= 0.5
                  ? (20 * (rounded - 0.375) / 0.125)
                  : 20
              : 20);
      y2 = 50 -
          (rounded > 0.375
              ? rounded <= 0.5
                  ? (60 * (rounded - 0.375) / 0.125)
                  : 60
              : 60);
      canvas.drawLine(
        Offset(
          //-20,
          x,
          //50,
          y,
        ),
        Offset(
          //0,
          x2,
          //-10,
          y2,
        ),
        rounded > 0.375 ? _paint : _unPaint,
      );

      x = x2;
      y = y2;
      x2 = 0 +
          (rounded > 0.5
              ? rounded <= 0.625
                  ? (10 * (rounded - 0.5) / 0.125)
                  : 10
              : 10);
      y2 = -10 +
          (rounded > 0.5
              ? rounded <= 0.625
                  ? (80 * (rounded - 0.5) / 0.125)
                  : 80
              : 80);

      canvas.drawLine(
        Offset(
          //0,
          x,
          //-10,
          y,
        ),
        Offset(
          //10,
          x2,
          //70,
          y2,
        ),
        rounded > 0.5 ? _paint : _unPaint,
      );

      x = x2;
      y = y2;
      x2 = 10 +
          (rounded > 0.625
              ? rounded <= 0.75
                  ? (15 * (rounded - 0.625) / 0.125)
                  : 15
              : 15);
      y2 = 70 -
          (rounded > 0.625
              ? rounded <= 0.75
                  ? (55 * (rounded - 0.625) / 0.125)
                  : 55
              : 55);

      canvas.drawLine(
        Offset(
          //10,
          x,
          //70,
          y,
        ),
        Offset(
          //25,
          x2,
          //15,
          y2,
        ),
        rounded > 0.625 ? _paint : _unPaint,
      );

      x = x2;
      y = y2;
      x2 = 25 +
          (rounded > 0.75
              ? rounded <= 0.875
                  ? (5 * (rounded - 0.75) / 0.125)
                  : 5
              : 5);
      y2 = 15 +
          (rounded > 0.75
              ? rounded <= 0.875
                  ? (10 * (rounded - 0.75) / 0.125)
                  : 10
              : 10);

      canvas.drawLine(
        Offset(
          //25,
          x,
          //15,
          y,
        ),
        Offset(
          //30,
          x2,
          //25,
          y2,
        ),
        rounded > 0.75 ? _paint : _unPaint,
      );

      x = x2;
      y = y2;
      x2 = 30 +
          (rounded > 0.875
              ? rounded <= 1
                  ? (60 * (rounded - 0.875) / 0.125)
                  : 60
              : 60);
      y2 = 25;

      canvas.drawLine(
        Offset(
          //30,
          x,
          //25,
          y,
        ),
        Offset(
          //90,
          x2,
          //25,
          y2,
        ),
        rounded > 0.875 ? _paint : _unPaint,
      );
    } else {
      canvas.drawLine(
        const Offset(-90, 25),
        Offset(
          -90 + (180 * progress),
          25,
        ),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(HeartBeatPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
