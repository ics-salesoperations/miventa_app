import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';

class PDVMarkerPainter extends CustomPainter {
  final bool visitado;
  final String segmento;
  final bool fd11;
  final bool quiebreMBL;
  final bool quiebreTMY;

  PDVMarkerPainter({
    this.visitado = false,
    required this.segmento,
    this.fd11 = false,
    this.quiebreMBL = false,
    this.quiebreTMY = false,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final priPaint = Paint()..color = kPrimaryColor.withOpacity(0.7);
    final secPaint = Paint()..color = kSecondaryColor.withOpacity(0.7);
    final thiPaint = Paint()..color = kThirdColor.withOpacity(0.7);
    final badPaint = Paint()..color = Colors.red.shade400;
    final Paint whitePaint = Paint()..color = Colors.white;

    const double circleThirdRadius = 45;

    canvas.drawArc(
      Rect.fromCenter(
        center:
            Offset(circleThirdRadius - 22, size.height - circleThirdRadius / 2),
        height: circleThirdRadius,
        width: circleThirdRadius,
      ),
      math.pi,
      (2 / 3) * math.pi - 0.1,
      false,
      quiebreTMY ? badPaint : thiPaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center:
            Offset(circleThirdRadius - 22, size.height - circleThirdRadius / 2),
        height: circleThirdRadius,
        width: circleThirdRadius,
      ),
      (5 / 3) * math.pi,
      (2 / 3) * math.pi - 0.1,
      false,
      fd11 ? badPaint : secPaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center:
            Offset(circleThirdRadius - 22, size.height - circleThirdRadius / 2),
        height: circleThirdRadius,
        width: circleThirdRadius,
      ),
      (7 / 3) * math.pi,
      (2 / 3) * math.pi - 0.1,
      false,
      quiebreMBL ? badPaint : priPaint,
    );

    /*
    canvas.drawCircle(
        Offset(circleThirdRadius - 22, size.height - circleThirdRadius / 2),
        circleThirdRadius / 2.0,
        thirdPaint);*/
    canvas.drawCircle(
      Offset(circleThirdRadius - 22, size.height - circleThirdRadius / 2),
      circleThirdRadius / 2.5,
      whitePaint,
    );

    /*NUEVO AGREGADO */
    const iconData = Icons.store;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final iconStr = String.fromCharCode(iconData.codePoint);

    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 28, //60,
          fontFamily: iconData.fontFamily,
          color: visitado ? kPrimaryColor : kSecondaryColor,
        ));
    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(9, size.height - 37),
    );

    //Segmento
    final textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      text: segmento,
    );

    final segPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 30,
        maxWidth: 30,
      );

    segPainter.paint(
      canvas,
      Offset(8, size.height - 67),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
