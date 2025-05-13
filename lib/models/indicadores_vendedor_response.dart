// To parse this JSON data, do
//
//     final IndicadoresVendedorResponse = IndicadoresVendedorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

IndicadoresVendedorResponse indicadoresVendedorResponseFromJson(String str) =>
    IndicadoresVendedorResponse.fromJson(json.decode(str));

String indicadoresVendedorResponseToJson(IndicadoresVendedorResponse data) =>
    json.encode(data.toJson());

class IndicadoresVendedorResponse {
  IndicadoresVendedorResponse({
    this.flag,
    this.indicadoresVendedor= const <IndicadoresVendedor>[],
  });

  String? flag;
  List<IndicadoresVendedor> indicadoresVendedor;

  IndicadoresVendedorResponse copyWith({
    String? flag,
    List<IndicadoresVendedor>? indicadoresVendedor,
  }) =>
      IndicadoresVendedorResponse(
        flag: flag ?? this.flag,
        indicadoresVendedor: indicadoresVendedor ?? this.indicadoresVendedor,
      );

  factory IndicadoresVendedorResponse.fromJson(Map<String, dynamic> json) {
    return IndicadoresVendedorResponse(
      flag: json["flag"],
      indicadoresVendedor: List<IndicadoresVendedor>.from(
        json["indicadoresVendedor"].map(
          (x) {
            return IndicadoresVendedor.fromMap(x);
          },
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "indicadoresVendedor":
            List<dynamic>.from(indicadoresVendedor.map((x) => x.toJson())),
      };
}
