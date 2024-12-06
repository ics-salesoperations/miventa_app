// To parse this JSON data, do
//
//     final ModeloTangibleResponse = ModeloTangibleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

ProductoTangibleReasignacionResponse productoTangibleReasignacionResponseFromJson(String str) =>
    ProductoTangibleReasignacionResponse.fromJson(json.decode(str));

String productoTangibleReasignacionResponseToJson(ProductoTangibleReasignacionResponse data) =>
    json.encode(data.toJson());

class ProductoTangibleReasignacionResponse {
  ProductoTangibleReasignacionResponse({
    this.flag,
    this.tangiblesReasignados = const <ProductoTangibleReasignacion>[],
  });

  String? flag;
  List<ProductoTangibleReasignacion> tangiblesReasignados;

  ProductoTangibleReasignacionResponse copyWith({
    String? flag,
    List<ProductoTangibleReasignacion>? tangiblesReasignados,
  }) =>
      ProductoTangibleReasignacionResponse(
        flag: flag ?? this.flag,
        tangiblesReasignados: tangiblesReasignados ?? this.tangiblesReasignados,
      );

  factory ProductoTangibleReasignacionResponse.fromJson(Map<String, dynamic> json) =>
      ProductoTangibleReasignacionResponse(
        flag: json["flag"],
        tangiblesReasignados: List<ProductoTangibleReasignacion>.from(
          json["tangiblesReasignados"].map(
            (x) {
              return ProductoTangibleReasignacion.fromMap(x);
            },
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "tangiblesReasignados":
            List<dynamic>.from(tangiblesReasignados.map((x) => x.toJson())),
      };
}
