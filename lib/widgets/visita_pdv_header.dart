import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';

class VisitaPDVHeader extends StatelessWidget {
  final Planning detalle;
  final String titulo;

  const VisitaPDVHeader({Key? key, required this.detalle, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
              fontFamily: 'Cronos-Pro',
            ),
          ),
          Text(
            detalle.idPdv!.toString() + ' - ' + detalle.nombrePdv!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'Cronos-Pro',
            ),
          ),
        ],
      ),
    );
  }
}
