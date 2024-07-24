import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/formulario.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SOSeleccionUnicaField extends StatelessWidget {
  final Formulario campo;

  const SOSeleccionUnicaField({Key? key, required this.campo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> valores = campo.offeredAnswer.toString().split(",");

    return ReactiveDropdownField(
      formControlName: '${campo.questionText}',
      validationMessages: {
        ValidationMessage.required: (control) =>
            '${campo.questionText} es requerido',
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: kPrimaryColor),
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
          fontSize: 16,
          color: kSecondaryColor,
          fontFamily: 'CronosSPro',
        ),
      ),
      items: valores
          .map<DropdownMenuItem>((valor) => DropdownMenuItem(
                value: valor,
                child: Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kSecondaryColor,
                    fontFamily: 'CronosLPro',
                  ),
                ),
              ))
          .toList(),
    );
  }
}
