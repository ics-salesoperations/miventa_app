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
    this.incentivosPDV = const <IncentivoPdv>[],
  });

  String? flag;
  List<IncentivoPdv> incentivosPDV;

  IncentivoPdvResponse copyWith({
    String? flag,
    List<IncentivoPdv>? incentivosPDV,
  }) =>
      IncentivoPdvResponse(
        flag: flag ?? this.flag,
        incentivosPDV: incentivosPDV ?? this.incentivosPDV,
      );

  factory IncentivoPdvResponse.fromJson(Map<String, dynamic> json) {
    return IncentivoPdvResponse(
      flag: json["flag"],
      incentivosPDV: List<IncentivoPdv>.from(
        json["incentivosPDV"].map(
          (x) {
            return IncentivoPdv.fromMap(x);
          },
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "incentivosPDV":
            List<dynamic>.from(incentivosPDV.map((x) => x.toJson())),
      };
}
