import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SOSeleccionUnicaFieldCustom extends StatelessWidget {
  final FormGroup form;
  final String campo;
  final String label;
  final String listaValores;

  const SOSeleccionUnicaFieldCustom({
    Key? key,
    required this.campo,
    required this.listaValores,
    required this.form,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> valores = listaValores.toString().split(",");

    return ReactiveDropdownField<String>(
      formControlName: campo,
      validationMessages: {
        ValidationMessage.required: (error) => '$label es requerido',
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
        labelText: label,
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
          .map<DropdownMenuItem<String>>((valor) => DropdownMenuItem(
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
