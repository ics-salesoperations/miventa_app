// To parse this JSON data, do
//
//     final formResponse = formResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

FormResponse formResponseFromMap(String str) =>
    FormResponse.fromMap(json.decode(str));

String formResponseToJson(FormResponse data) => json.encode(data.toJson());

class FormResponse {
  FormResponse({
    this.flag,
    this.detalleFormulario = const [],
  });

  String? flag;
  final List<Formulario> detalleFormulario;

  FormResponse copyWith({
    String? flag,
    List<Formulario>? detalleFormulario,
  }) =>
      FormResponse(
        flag: flag ?? this.flag,
        detalleFormulario: detalleFormulario ?? this.detalleFormulario,
      );

  factory FormResponse.fromMap(Map<String, dynamic> json) => FormResponse(
        flag: json["flag"],
        detalleFormulario: List<Formulario>.from(
            json["detalleFormulario"].map((x) => Formulario.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "detalleFormulario":
            List<dynamic>.from(detalleFormulario.map((x) => x.toJson())),
      };
}
