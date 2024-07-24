// To parse this JSON data, do
//
//     final ModeloTangibleResponse = ModeloTangibleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

ModeloTangibleResponse modeloTangibleResponseFromJson(String str) =>
    ModeloTangibleResponse.fromJson(json.decode(str));

String modeloTangibleResponseToJson(ModeloTangibleResponse data) =>
    json.encode(data.toJson());

class ModeloTangibleResponse {
  ModeloTangibleResponse({
    this.flag,
    this.catalogoModelos = const <ModeloTangible>[],
  });

  String? flag;
  List<ModeloTangible> catalogoModelos;

  ModeloTangibleResponse copyWith({
    String? flag,
    List<ModeloTangible>? catalogoModelos,
  }) =>
      ModeloTangibleResponse(
        flag: flag ?? this.flag,
        catalogoModelos: catalogoModelos ?? this.catalogoModelos,
      );

  factory ModeloTangibleResponse.fromJson(Map<String, dynamic> json) {
    return ModeloTangibleResponse(
      flag: json["flag"],
      catalogoModelos: List<ModeloTangible>.from(
        json["catalogoModelos"].map(
          (x) {
            return ModeloTangible.fromMap(x);
          },
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "catalogoModelos":
            List<dynamic>.from(catalogoModelos.map((x) => x.toJson())),
      };
}
