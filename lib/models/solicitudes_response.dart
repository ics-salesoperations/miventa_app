// To parse this JSON data, do
//
//     final planningResponse = planningResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

SolicitudesResponse solicitudesResponseFromJson(String str) =>
    SolicitudesResponse.fromJson(json.decode(str));

String solicitudesResponseToJson(SolicitudesResponse data) =>
    json.encode(data.toJson());

class SolicitudesResponse {
  SolicitudesResponse({
    this.status,
    this.records,
    this.data = const <Solicitudes>[],
  });

  String? status;
  int? records;
  List<Solicitudes> data;

  SolicitudesResponse copyWith({
    String? status,
    int? records,
    List<Solicitudes>? data,
  }) =>
      SolicitudesResponse(
        status: status ?? this.status,
        records: records ?? this.records,
        data: data ?? this.data,
      );

  factory SolicitudesResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesResponse(
        status: json["status"],
        records: json["records"],
        data: List<Solicitudes>.from(
          json["data"].map(
            (x) {
              return Solicitudes.fromMap(x);
            },
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "records": records,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
