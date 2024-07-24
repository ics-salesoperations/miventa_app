import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/formulario.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SONumberField extends StatelessWidget {
  final Formulario campo;

  const SONumberField({Key? key, required this.campo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: '${campo.questionText}',
      validationMessages: {
        ValidationMessage.required: (control) =>
            '${campo.questionText} es requerido',
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
        ),
        labelText: "${campo.questionText}",
        labelStyle: const TextStyle(
          fontSize: 16,
          color: kSecondaryColor,
          fontFamily: 'CronosLPro',
        ),
        floatingLabelStyle: const TextStyle(
            fontSize: 16, color: kSecondaryColor, fontFamily: 'CronosSPro'),
      ),
    );
  }
}
