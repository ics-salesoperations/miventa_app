import 'package:flutter/material.dart';

class EndMarkerPainter extends CustomPainter {
  final int kilometers;
  final String destination;

  EndMarkerPainter({
    required this.kilometers,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()
      ..color = const Color.fromRGBO(0, 25, 79, 1); //lapiz para pintar negro
    final whitePaint = Paint()..color = Colors.white; //lapiz para pintar blanco

    /*NUEVO AGREGADO */
    const iconData = Icons.store;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final iconStr = String.fromCharCode(iconData.codePoint);

    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 44,
          fontFamily: iconData.fontFamily,
          color: const Color.fromRGBO(0, 25, 79, 1),
        ));
    textPainter.layout();

    textPainter.paint(canvas, Offset(0.0, size.height - 44));

    /*FIN NUEVO AGREGADO*/

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
    canvas.drawRect(blackBoxRect, bluePaint);

    //Textos
    //Minutos
    final textSpan = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 50,
        fontWeight: FontWeight.w400,
      ),
      text: kilometers.toString(),
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
      text: 'Kms',
    );

    final minPainter = TextPainter(
      text: minText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70,
        maxWidth: 70,
      );

    minPainter.paint(canvas, const Offset(40, 69));

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
        minWidth: size.width - 170,
        maxWidth: size.width - 170,
      );

    final double offsetY = (destination.length > 22) ? 22 : 37;

    locationPainter.paint(canvas, Offset(160, offsetY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
