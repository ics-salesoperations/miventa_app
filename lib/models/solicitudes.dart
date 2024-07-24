import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class Solicitudes extends Model {
  static String table = 'solicitud';

  Solicitudes({
    id,
    this.codigo,
    this.idPdv,
    this.formId,
    this.formName,
    this.fecha,
    this.fechaRespuesta,
    this.comentarios,
    this.estado,
    this.usuario,
  }) : super(id);

  String? codigo;
  String? idPdv;
  String? formId;
  String? formName;
  DateTime? fecha;
  DateTime? fechaRespuesta;
  String? comentarios;
  String? estado;
  String? usuario;

  Solicitudes copyWith({
    String? codigo,
    String? idPdv,
    String? formId,
    String? formName,
    DateTime? fecha,
    DateTime? fechaRespuesta,
    String? comentarios,
    String? estado,
    String? usuario,
  }) =>
      Solicitudes(
        codigo: codigo ?? this.codigo,
        idPdv: idPdv ?? this.idPdv,
        formId: formId ?? this.formId,
        formName: formName ?? this.formName,
        fecha: fecha ?? this.fecha,
        fechaRespuesta: fechaRespuesta ?? this.fechaRespuesta,
        comentarios: comentarios ?? this.comentarios,
        estado: estado ?? this.estado,
        usuario: usuario ?? this.usuario,
      );

  factory Solicitudes.fromMap(Map<String, dynamic> json) => Solicitudes(
        id: json["id"],
        codigo: json["codigo"].toString(),
        idPdv: json["idPdv"].toString(),
        formId: json["formId"].toString(),
        formName: json["formName"].toString(),
        fecha: json["fecha"] == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss').parse(json["fecha"]),
        fechaRespuesta: json["fechaRespuesta"] == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss').parse(json["fechaRespuesta"]),
        comentarios: json["comentarios"].toString(),
        estado: json["estado"].toString(),
        usuario: json["usuario"].toString(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "idPdv": idPdv,
        "formId": formId,
        "formName": formName,
        "fecha": fecha != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(fecha!)
            : null,
        "fechaRespuesta": fechaRespuesta != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaRespuesta!)
            : null,
        "comentarios": comentarios,
        "estado": estado,
        "usuario": usuario,
      };
}
