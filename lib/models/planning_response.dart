// To parse this JSON data, do
//
//     final planningResponse = planningResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

PlanningResponse planningResponseFromJson(String str) =>
    PlanningResponse.fromJson(json.decode(str));

String planningResponseToJson(PlanningResponse data) =>
    json.encode(data.toJson());

class PlanningResponse {
  PlanningResponse({
    this.flag,
    this.planning = const <Planning>[],
  });

  String? flag;
  List<Planning> planning;

  PlanningResponse copyWith({
    String? flag,
    List<Planning>? planning,
  }) =>
      PlanningResponse(
        flag: flag ?? this.flag,
        planning: planning ?? this.planning,
      );

  factory PlanningResponse.fromJson(Map<String, dynamic> json) =>
      PlanningResponse(
        flag: json["flag"],
        planning: List<Planning>.from(
          json["detallePdvs"].map(
            (x) {
              return Planning.fromJson(x);
            },
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "detallePdvs": List<dynamic>.from(planning.map((x) => x.toJson())),
      };
}
