import 'package:flutter/cupertino.dart';
import 'package:miventa_app/models/model.dart';

class ModeloTangible extends Model {
  static String table = 'modelo';

  ModeloTangible({
    id,
    this.tangible,
    this.modelo,
    this.descripcion,
    this.imagen,
    this.asignado = 0,
    this.disponible = 0,
    this.serieInicial = '0',
    this.serieFinal = '0',
    this.descartado = 0,
  }) : super(id);

  String? tangible;
  String? modelo;
  String? descripcion;
  String? imagen;
  int asignado;
  int disponible;
  String? serieInicial;
  String? serieFinal;
  int descartado;
  TextEditingController controller = TextEditingController();

  ModeloTangible copyWith({
    int? id,
    String? tangible,
    String? modelo,
    String? descripcion,
    String? imagen,
    int? asignado,
    int? disponible,
    String? serieInicial,
    String? serieFinal,
    int? descartado,
  }) =>
      ModeloTangible(
        id: id ?? this.id,
        tangible: tangible ?? this.tangible,
        modelo: modelo ?? this.modelo,
        descripcion: descripcion ?? this.descripcion,
        imagen: imagen ?? this.imagen,
        asignado: asignado ?? this.asignado,
        disponible: disponible ?? this.disponible,
        serieInicial: serieInicial ?? this.serieInicial,
        serieFinal: serieFinal ?? this.serieFinal,
        descartado: descartado ?? this.descartado,
      );

  factory ModeloTangible.fromMap(Map<String, dynamic> json) => ModeloTangible(
        id: json["id"],
        tangible: json["tangible"] ?? json["categoria"],
        modelo: json["modelo"],
        descripcion: json["descripcion"] ?? json["descripcionModelo"],
        imagen: json["imagen"] ?? '',
        asignado: json["asignado"] ?? 0,
        disponible: json["disponible"] ?? 0,
        serieInicial: json["serieInicial"],
        serieFinal: json["serieFinal"],
        descartado: json["descartado"] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "tangible": tangible,
        "modelo": modelo,
        "descripcion": descripcion,
        "imagen": imagen,
        "asignado": asignado,
        "disponible": disponible,
        "serieInicial": serieInicial,
        "serieFinal": serieFinal,
        "descartado": descartado,
      };
}
