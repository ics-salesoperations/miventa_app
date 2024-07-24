import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class SolicitudAutomatica extends Model {
  static String table = 'solicitud_automatica';

  SolicitudAutomatica({
    id,
    this.fecha,
    this.usuario,
    this.idPdv,
    this.tipo,
    this.enviado = 0,
  }) : super(id);

  DateTime? fecha;
  String? usuario;
  String? idPdv;
  String? tipo;
  int? enviado;

  SolicitudAutomatica copyWith({
    int? id,
    DateTime? fecha,
    String? usuario,
    String? idPdv,
    String? tipo,
    int? enviado,
  }) =>
      SolicitudAutomatica(
        id: id ?? this.id,
        fecha: fecha ?? this.fecha,
        usuario: usuario ?? this.usuario,
        idPdv: idPdv ?? this.idPdv,
        tipo: tipo ?? this.tipo,
        enviado: enviado ?? this.enviado,
      );

  factory SolicitudAutomatica.fromMap(Map<String, dynamic> json) {
    final int? dateYear = json["fecha"] == null
        ? null
        : int.parse(json["fecha"].toString().substring(0, 4));

    final int? dateMonth = json["fecha"] == null
        ? null
        : int.parse(json["fecha"].toString().substring(4, 6));

    final int? dateDay = json["fecha"] == null
        ? null
        : int.parse(json["fecha"].toString().substring(6, 8));

    final int? dateHour = json["fecha"] == null
        ? null
        : int.parse(json["fecha"].toString().substring(9, 11));

    final int? dateMinute = json["fecha"] == null
        ? null
        : int.parse(json["fecha"].toString().substring(11, 13));

    final int? dateSecond = json["fecha"] == null
        ? null
        : int.parse(json["fecha"].toString().substring(13, 15));

    return SolicitudAutomatica(
      id: json["id"],
      fecha: json["fecha"] == null
          ? null
          : DateTime(
              dateYear!,
              dateMonth!,
              dateDay!,
              dateHour!,
              dateMinute!,
              dateSecond!,
            ),
      usuario: json["usuario"].toString(),
      idPdv: json["idPdv"].toString(),
      tipo: json["tipo"].toString(),
      enviado: json["enviado"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha":
            fecha != null ? DateFormat('yyyyMMdd:HHmmss').format(fecha!) : null,
        "usuario": usuario,
        "idPdv": idPdv,
        "tipo": tipo,
        "enviado": enviado,
      };
}
