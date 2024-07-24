import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class ResumenSincronizar extends Model {
  ResumenSincronizar({
    id,
    this.fecha,
    this.tipo,
    this.porcentajeSync,
    this.idPdv,
    this.nombrePdv,
    this.idVisita,
  }) : super(id);

  DateTime? fecha;
  String? tipo;
  int? porcentajeSync;
  int? idPdv;
  String? nombrePdv;
  String? idVisita;

  factory ResumenSincronizar.fromJson(Map<String, dynamic> json) {
    final fecha = DateTime(
      int.parse(json["fecha"].toString().substring(0, 4)),
      int.parse(json["fecha"].toString().substring(4, 6)),
      int.parse(json["fecha"].toString().substring(6, 8)),
      int.parse(json["fecha"].toString().substring(9, 11)),
      int.parse(json["fecha"].toString().substring(11, 13)),
      int.parse(json["fecha"].toString().substring(13, 15)),
    );

    return ResumenSincronizar(
      fecha: fecha,
      tipo: json["tipo"].toString(),
      idVisita: json["idVisita"].toString(),
      porcentajeSync: json["porcentajeSync"],
      nombrePdv: json["nombrePdv"].toString(),
      idPdv: json["idPdv"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "fecha": DateFormat('yyyyMMdd:HHmmss').format(fecha!),
        "tipo": tipo,
        "porcentajeSync": porcentajeSync,
        "idPdv": idPdv,
        "nombrePdv": nombrePdv,
        "idVisita": idVisita,
      };
}
