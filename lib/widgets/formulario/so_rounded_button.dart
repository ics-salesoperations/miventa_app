import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';

class SORoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback funcion;

  const SORoundedButton({Key? key, required this.label, required this.funcion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 2500, height: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            elevation: 0),
        onPressed: funcion,
        child: Text(label,
            style: const TextStyle(
              fontSize: 22,
              color: kSecondaryColor,
              fontFamily: 'CronosLPro',
            )),
      ),
    );
  }
}
