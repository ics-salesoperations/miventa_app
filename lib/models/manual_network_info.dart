import 'dart:convert';

import 'package:miventa_app/models/models.dart';

ManualNetworkInfo manualNetworkInfoFromMap(String str) =>
    ManualNetworkInfo.fromMap(json.decode(str));
String manualNetworkInfoToJson(ManualNetworkInfo data) =>
    json.encode(data.toJson());

class ManualNetworkInfo extends Model {
  static String table = 'manualnetworkinfo';
  String? idLectura;
  String? departamento;
  String? municipio;
  String? zona;
  String? ambiente;
  String? tipoAmbiente;
  String? descripcionAmbiente;
  String? comentarios;
  String? colonia;
  DateTime? fallaDesde;
  String? horas;
  String? tipoAfectacion;
  String? afectacion;
  String? fotografia;
  String? enviado;
  double? mbSubida;
  double? mbBajada;

  ManualNetworkInfo({
    id,
    this.idLectura,
    this.departamento,
    this.municipio,
    this.zona,
    this.ambiente,
    this.tipoAmbiente,
    this.descripcionAmbiente,
    this.comentarios,
    this.colonia,
    this.fallaDesde,
    this.horas,
    this.tipoAfectacion,
    this.afectacion,
    this.fotografia,
    this.enviado,
    this.mbBajada,
    this.mbSubida,
  }) : super(id);

  static ManualNetworkInfo fromMap(Map<String, dynamic> json) {
    return ManualNetworkInfo(
      id: json['id'],
      idLectura: json['idLectura'].toString(),
      departamento: json['departamento'].toString(),
      municipio: json['municipio'].toString(),
      zona: json['zona'].toString(),
      ambiente: json['ambiente'].toString(),
      tipoAmbiente: json['tipoAmbiente'].toString(),
      descripcionAmbiente: json['descripcionAmbiente'].toString(),
      comentarios: json['comentarios'].toString(),
      colonia: json['colonia'].toString(),
      fallaDesde: DateTime.parse(json['fallaDesde'].toString()),
      horas: json['horas'].toString(),
      tipoAfectacion: json['tipoAfectacion'].toString(),
      afectacion: json['afectacion'].toString(),
      fotografia: json['fotografia'].toString(),
      enviado: json['enviado'].toString(),
      mbBajada: json['mbBajada'] == null ? 0 : json['mbBajada'].toDouble(),
      mbSubida: json['mbSubida'] == null ? 0 : json['mbSubida'].toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "idLectura": idLectura,
      "departamento": departamento,
      "municipio": municipio,
      "zona": zona,
      "ambiente": ambiente,
      "tipoAmbiente": tipoAmbiente,
      "descripcionAmbiente": descripcionAmbiente,
      "comentarios": comentarios,
      "colonia": colonia,
      "fallaDesde": fallaDesde!.toIso8601String(),
      "horas": horas,
      "tipoAfectacion": tipoAfectacion,
      "afectacion": afectacion,
      "fotografia": fotografia,
      "enviado": enviado,
      "mbBajada": mbBajada,
      "mbSubida": mbSubida,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  ManualNetworkInfo copyWith({
    int? id,
    String? idLectura,
    String? departamento,
    String? municipio,
    String? zona,
    String? ambiente,
    String? tipoAmbiente,
    String? descripcionAmbiente,
    String? comentarios,
    String? colonia,
    DateTime? fallaDesde,
    String? horas,
    String? tipoAfectacion,
    String? afectacion,
    String? fotografia,
    String? enviado,
    double? mbSubida,
    double? mbBajada,
  }) =>
      ManualNetworkInfo(
        id: id ?? this.id,
        idLectura: idLectura ?? this.idLectura,
        departamento: departamento ?? this.departamento,
        municipio: municipio ?? this.municipio,
        zona: zona ?? this.zona,
        ambiente: ambiente ?? this.ambiente,
        tipoAmbiente: tipoAmbiente ?? this.tipoAmbiente,
        descripcionAmbiente: descripcionAmbiente ?? this.descripcionAmbiente,
        comentarios: comentarios ?? this.comentarios,
        colonia: colonia ?? this.colonia,
        fallaDesde: fallaDesde ?? this.fallaDesde,
        horas: horas ?? this.horas,
        tipoAfectacion: tipoAfectacion ?? this.tipoAfectacion,
        afectacion: afectacion ?? this.afectacion,
        fotografia: fotografia ?? this.fotografia,
        enviado: enviado ?? this.enviado,
        mbSubida: mbSubida ?? this.mbSubida,
        mbBajada: mbBajada ?? this.mbBajada,
      );
}
