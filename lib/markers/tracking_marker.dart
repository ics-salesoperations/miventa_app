import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';

class TrackingMarker extends CustomPainter {
  final int order;

  TrackingMarker(this.order);
  @override
  void paint(Canvas canvas, Size size) {
    /*NUEVO AGREGADO */
    const iconData = Icons.location_searching;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final iconStr = String.fromCharCode(iconData.codePoint);

    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 40, //60,
          fontFamily: iconData.fontFamily,
          color: kPrimaryColor,
        ));
    textPainter.layout();

    textPainter.paint(canvas, Offset(0, size.height - 40));

    //ORDER
    final textSpan = TextSpan(
      style: const TextStyle(
        color: kPrimaryColor,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: order.toString(),
    );

    final orderPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    orderPainter.paint(canvas, const Offset(-30, 80));

    /*FIN NUEVO AGREGADO*/
/*
    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    //Circulo negro
    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleBlackRadius,
      blackPaint,
    );

    //Circulo blanco
    canvas.drawCircle(
      Offset(circleBlackRadius, size.height - circleBlackRadius),
      circleWhiteRadius,
      whitePaint,
    );

    //Dibujar Caja Blanca
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    //Sombra de la caja
    canvas.drawShadow(path, Colors.black, 10, false);

    //Caja
    canvas.drawPath(path, whitePaint);

    //Caja negra
    const blackBoxRect = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBoxRect, blackPaint);

    //Textos
    //Minutos
    final textSpan = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: minutes.toString(),
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minutesPainter.paint(canvas, const Offset(40, 35));

    //palabra MIN
    const minText = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      text: 'Min',
    );

    final minPainter = TextPainter(
      text: minText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minPainter.paint(canvas, const Offset(40, 68));

    final locationText = TextSpan(
      style: const TextStyle(
        color: Color.fromRGBO(0, 25, 79, 1),
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      text: destination,
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(
        minWidth: size.width - 135,
        maxWidth: size.width - 135,
      );

    final double offsetY = (destination.length > 20) ? 35 : 48;

    locationPainter.paint(canvas, Offset(120, offsetY));*/
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
