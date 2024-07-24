import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class Fordis11 extends Model {
  Fordis11(
      {id,
      required this.fechaFD11,
      required this.nombreCircuito,
      required this.idPdv,
      required this.nombrePdv,
      required this.fd11,
      this.contestado = "NO"})
      : super(id);

  DateTime fechaFD11;
  String nombreCircuito;
  int idPdv;
  String nombrePdv;
  String fd11;
  String contestado;

  factory Fordis11.fromJson(Map<String, dynamic> json) => Fordis11(
        fechaFD11: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json["fechaFD11"]),
        nombreCircuito: json["nombreCircuito"],
        idPdv: json["idPdv"],
        nombrePdv: json["nombrePdv"].toString(),
        fd11: json["fd11"].toString(),
        contestado: json["contestado"].toString(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "fechaFD11": DateFormat('dd-MM-yyyy HH:mm:ss').format(fechaFD11),
        "nombreCircuito": nombreCircuito,
        "idPdv": idPdv,
        "nombrePdv": nombrePdv,
        "fd11": fd11,
        "contestado": contestado,
      };
}
