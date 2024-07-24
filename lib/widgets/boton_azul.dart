import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final onPressed;
  final bool procesando;

  const BotonAzul({
    Key? key,
    required this.text,
    required this.onPressed,
    this.procesando = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(32)),
        width: double.infinity,
        height: 55,
        child: Center(
          child: procesando
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
