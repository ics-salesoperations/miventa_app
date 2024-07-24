import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';

class InfoElementList extends StatelessWidget {
  final String label;
  final String value;

  const InfoElementList({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.only(left: 25),
        height: 35,
        /*decoration: const BoxDecoration(
          color: kThirdColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),*/
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
                fontFamily: 'CronosSPro',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: kSecondaryColor,
                fontFamily: 'CronosLPro',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
