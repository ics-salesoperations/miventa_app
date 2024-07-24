// To parse this JSON data, do
//
//     final ModeloTangibleResponse = ModeloTangibleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

ProductoTangibleResponse productoTangibleResponseFromJson(String str) =>
    ProductoTangibleResponse.fromJson(json.decode(str));

String productoTangibleResponseToJson(ProductoTangibleResponse data) =>
    json.encode(data.toJson());

class ProductoTangibleResponse {
  ProductoTangibleResponse({
    this.flag,
    this.tangiblesAsignados = const <ProductoTangible>[],
  });

  String? flag;
  List<ProductoTangible> tangiblesAsignados;

  ProductoTangibleResponse copyWith({
    String? flag,
    List<ProductoTangible>? tangiblesAsignados,
  }) =>
      ProductoTangibleResponse(
        flag: flag ?? this.flag,
        tangiblesAsignados: tangiblesAsignados ?? this.tangiblesAsignados,
      );

  factory ProductoTangibleResponse.fromJson(Map<String, dynamic> json) =>
      ProductoTangibleResponse(
        flag: json["flag"],
        tangiblesAsignados: List<ProductoTangible>.from(
          json["tangiblesAsignados"].map(
            (x) {
              return ProductoTangible.fromMap(x);
            },
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "tangiblesAsignados":
            List<dynamic>.from(tangiblesAsignados.map((x) => x.toJson())),
      };
}
