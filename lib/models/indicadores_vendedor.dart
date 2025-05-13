import 'package:flutter/cupertino.dart';
import 'package:miventa_app/models/model.dart';

class IndicadoresVendedor extends Model {
  static String table = 'indicadores';

  IndicadoresVendedor({
    id,
    this.anomes,
    this.indicador,
    this.m0,
    this.m1,
    this.varianza
  }) : super(id);

  int? anomes;
  String? indicador;
  double? m0;
  double? m1;
  double? varianza;

  TextEditingController controller = TextEditingController();

  IndicadoresVendedor copyWith({
    int? id,
    int? anomes,
    String? indicador,
    double? m0,
    double? m1,
    double? varianza
  }) =>
      IndicadoresVendedor(
        id: id ?? this.id,
        anomes: anomes ?? this.anomes,
        indicador: indicador ?? this.indicador,
        m0: m0 ?? this.m0,
        m1: m1 ?? this.m1,
        varianza: varianza ?? this.varianza
      );

  factory IndicadoresVendedor.fromMap(Map<String, dynamic> json) => IndicadoresVendedor(
    id: json["id"],
    anomes: json["anomes"],
    indicador: json["indicador"],
    m0: json["m0"] == null ? 0 : json["m0"] .toDouble(),
    m1: json["m1"] == null ? 0 : json["m1"] .toDouble(),
    varianza: json["varianza"] == null ? 0 : json["varianza"].toDouble()
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "anomes": anomes,
    "indicador": indicador,
    "m0": m0,
    "m1": m1,
    "varianza": varianza
  };
}
