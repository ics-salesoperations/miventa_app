import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_range_slider/reactive_range_slider.dart';

class SORangeCustom extends StatelessWidget {
  final String campo;
  final String label;
  final double min;
  final double max;
  final int divisions;

  const SORangeCustom({
    Key? key,
    required this.campo,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveRangeSlider(
      formControlName: campo,
      validationMessages: {
        ValidationMessage.required: (error) => '$label es requerido',
      },
      min: min,
      max: max,
      activeColor: kPrimaryColor,
      inactiveColor: Colors.grey.withOpacity(0.5),
      divisions: divisions,
      labelBuilder: (values) => RangeLabels(
        "${values.start.round()} horas",
        "${values.end.round()} horas",
      ),
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
