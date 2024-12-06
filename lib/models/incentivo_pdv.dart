import 'package:flutter/cupertino.dart';
import 'package:miventa_app/models/model.dart';

class IncentivoPdv extends Model {
  static String table = 'incentivo';

  IncentivoPdv({
    id,
    this.idPdv,
    this.incentivo,
    this.meta
  }) : super(id);

  int? idPdv;
  String? incentivo;
  int? meta;
 
  TextEditingController controller = TextEditingController();

  IncentivoPdv copyWith({
    int? id,
    int? idPdv,
    String? incentivo,
    int? meta,
  }) =>
      IncentivoPdv(
        id: id ?? this.id,
        idPdv: idPdv ?? this.idPdv,
        incentivo: incentivo ?? this.incentivo,
        meta: meta ?? this.meta,
      );

  factory IncentivoPdv.fromMap(Map<String, dynamic> json) => IncentivoPdv(
        id: json["id"],
        idPdv: json["idPdv"],
        incentivo: json["incentivo"],
        meta: json["meta"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idPdv": idPdv,
        "incentivo": incentivo,
        "meta": meta,
      };
}
