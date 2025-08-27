// To parse this JSON data, do
//
//     final SaldoVendedorResponse = SaldoVendedorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

SaldoVendedorResponse saldoVendedorResponseFromJson(String str) =>
    SaldoVendedorResponse.fromJson(json.decode(str));

String SaldoVendedorResponseToJson(SaldoVendedorResponse data) =>
    json.encode(data.toJson());

class SaldoVendedorResponse {
  SaldoVendedorResponse({
    this.flag,
    this.saldoVendedor = const <SaldoVendedor>[],
  });

  String? flag;
  List<SaldoVendedor> saldoVendedor;

  SaldoVendedorResponse copyWith({
    String? flag,
    List<SaldoVendedor>? saldoVendedor,
  }) =>
      SaldoVendedorResponse(
        flag: flag ?? this.flag,
        saldoVendedor: saldoVendedor ?? this.saldoVendedor,
      );

  factory SaldoVendedorResponse.fromJson(Map<String, dynamic> json) =>
      SaldoVendedorResponse(
        flag: json["flag"],
        saldoVendedor: List<SaldoVendedor>.from(
          json["saldosVendedor"].map(
            (x) {
              return SaldoVendedor.fromJson(x);
            },
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "saldosVendedor": List<dynamic>.from(saldoVendedor.map((x) => x.toJson())),
      };
}
