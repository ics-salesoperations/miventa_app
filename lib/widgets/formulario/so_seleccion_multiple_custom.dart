import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SOSeleccionMultipleCustom extends StatelessWidget {
  final String campo;
  final String label;
  final String listaValores;
  final FormGroup formGroup;

  const SOSeleccionMultipleCustom({
    Key? key,
    required this.campo,
    required this.formGroup,
    required this.label,
    required this.listaValores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> valores = listaValores.split(",");

    return ReactiveFormArray(
      formArrayName: campo,
      builder: (context, formArray, child) {
        return ReactiveForm(
          formGroup: formArray.controls[0] as FormGroup,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 14, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                      fontFamily: 'CronosSPro'),
                ),
                Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: [
                    ...valores
                        .map((valor) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ReactiveSwitch.adaptive(
                                  formControlName: valor,
                                  activeColor: kPrimaryColor,
                                ),
                                Text(
                                  valor,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: kSecondaryColor,
                                    fontFamily: 'CronosLPro',
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))
                        .toList(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
