import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {
  final int minutes;
  final String destination;

  StartMarkerPainter({
    required this.minutes,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()
      ..color = const Color.fromRGBO(0, 25, 79, 1); //lapiz para pintar negro
    final whitePaint = Paint()..color = Colors.white; //lapiz para pintar blanco

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
    path.moveTo(20, -20);
    path.lineTo(size.width - 20, -20);
    path.lineTo(size.width - 20, 110);
    path.lineTo(20, 110);
    //Sombra de la caja
    canvas.drawShadow(path, Colors.black, 10, false);

    //Caja
    canvas.drawPath(path, whitePaint);

    //Caja negra
    const blackBoxRect = Rect.fromLTWH(20, -20, 120, 130);
    canvas.drawRect(blackBoxRect, blackPaint);

    //Textos
    //Minutos
    final textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 50,
        fontWeight: FontWeight.w400,
      ),
      text: minutes.toString(),
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 110,
        maxWidth: 110,
      );

    minutesPainter.paint(canvas, const Offset(21, 15));

    //palabra MIN
    const minText = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
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
        fontSize: 30,
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

    final double offsetY = (destination.length > 25) ? 25 : 37;

    locationPainter.paint(canvas, Offset(160, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
