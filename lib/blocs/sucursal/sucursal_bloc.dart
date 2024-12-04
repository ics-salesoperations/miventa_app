// To parse this JSON data, do
//
//     final planningResponse = planningResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

SolicitudesResponse solicitudesGerResponseFromJson(String str) =>
    SolicitudesResponse.fromJson(json.decode(str));

String solicitudesResponseToJson(SolicitudesResponse data) =>
    json.encode(data.toJson());

class SolicitudesResponse {
  SolicitudesResponse({
    this.status,
    this.records,
    this.data = const <SolicitudesGer>[],
  });

  String? status;
  int? records;
  List<SolicitudesGer> data;

  SolicitudesResponse copyWith({
    String? status,
    int? records,
    List<Solicitudes>? data,
  }) =>
      SolicitudesResponse(
        status: status ?? this.status,
        records: records ?? this.records,
        data: data?.cast<SolicitudesGer>() ?? this.data,
      );

  factory SolicitudesResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesResponse(
        status: json["status"],
        records: json["records"],
        data: List<SolicitudesGer>.from(
          json["data"].map(
            (x) {
              return SolicitudesGer.fromMap(x);
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
