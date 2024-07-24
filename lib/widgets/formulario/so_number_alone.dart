import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SONumberAlone extends StatelessWidget {
  final String campo;

  const SONumberAlone({
    Key? key,
    required this.campo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: campo,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.top,
      readOnly: true,
      style: const TextStyle(
        color: kSecondaryColor,
        fontSize: 22,
        fontFamily: 'CronosLPro',
      ),
      decoration: const InputDecoration.collapsed(hintText: ""),
    );
  }
}
