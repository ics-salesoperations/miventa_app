// To parse this JSON data, do
//
//     final IncentivoPdvResponse = IncentivoPdvResponseFromJson(jsonString);

import 'dart:convert';

import 'package:miventa_app/models/models.dart';

IncentivoPdvResponse IncentivoPdvResponseFromJson(String str) =>
    IncentivoPdvResponse.fromJson(json.decode(str));

String IncentivoPdvResponseToJson(IncentivoPdvResponse data) =>
    json.encode(data.toJson());

class IncentivoPdvResponse {
  IncentivoPdvResponse({
    this.flag,
    this.incentivosPdv = const <IncentivoPdv>[],
  });

  String? flag;
  List<IncentivoPdv> incentivosPdv;

  IncentivoPdvResponse copyWith({
    String? flag,
    List<IncentivoPdv>? incentivosPdv,
  }) =>
      IncentivoPdvResponse(
        flag: flag ?? this.flag,
        incentivosPdv: incentivosPdv ?? this.incentivosPdv,
      );

  factory IncentivoPdvResponse.fromJson(Map<String, dynamic> json) {
    return IncentivoPdvResponse(
      flag: json["flag"],
      incentivosPdv: List<IncentivoPdv>.from(
        json["incentivosPdv"].map(
          (x) {
            return IncentivoPdv.fromMap(x);
          },
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "incentivosPdv":
            List<dynamic>.from(incentivosPdv.map((x) => x.toJson())),
      };
}
