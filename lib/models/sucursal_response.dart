// To parse this JSON data, do
//
//     final planningResponse = planningResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

SolicitudesGerResponse solicitudesGerResponseFromJson(String str) =>
    SolicitudesGerResponse.fromJson(json.decode(str));

String solicitudesGerResponseToJson(SolicitudesGerResponse data) =>
    json.encode(data.toJson());

class SolicitudesGerResponse {
  SolicitudesGerResponse({
    this.status,
    this.records,
    this.data = const <SolicitudesGer>[],
  });

  String? status;
  int? records;
  List<SolicitudesGer> data;

  SolicitudesGerResponse copyWith({
    String? status,
    int? records,
    List<SolicitudesGer>? data,
  }) =>
      SolicitudesGerResponse(
        status: status ?? this.status,
        records: records ?? this.records,
        data: data?.cast<SolicitudesGer>() ?? this.data,
      );

  factory SolicitudesGerResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesGerResponse(
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
