import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class ReporteQuiebre extends Model {
  ReporteQuiebre({
    id,
    required this.fechaActualizacion,
    required this.idPdv,
    required this.nombrePdv,
    required this.quiebre,
    this.saldo = "",
  }) : super(id);

  DateTime fechaActualizacion;
  int idPdv;
  String nombrePdv;
  String quiebre;
  String saldo;

  factory ReporteQuiebre.fromJson(Map<String, dynamic> json) => ReporteQuiebre(
        fechaActualizacion:
            DateFormat('dd-MM-yyyy HH:mm:ss').parse(json["fechaActualizacion"]),
        idPdv: json["idPdv"],
        nombrePdv: json["nombrePdv"].toString(),
        quiebre: json["quiebre"].toString(),
        saldo: json["saldo"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "fechaActualizacion":
            DateFormat('dd-MM-yyyy HH:mm:ss').format(fechaActualizacion),
        "idPdv": idPdv,
        "nombrePdv": nombrePdv,
        "quiebre": quiebre,
        "saldo": saldo,
      };
}
