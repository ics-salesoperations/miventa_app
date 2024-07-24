import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SODateCustom extends StatelessWidget {
  final String campo;
  final String label;
  final DateTime lastDate;

  const SODateCustom({
    Key? key,
    required this.campo,
    required this.label,
    required this.lastDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveDateTimePicker(
      formControlName: campo,
      validationMessages: {
        ValidationMessage.required: (error) => '$label es requerido',
      },
      dateFormat: DateFormat("dd/MM/yyyy"),
      lastDate: lastDate,
      //locale: const Locale('es', 'ES'),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
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
        labelText: label,
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
