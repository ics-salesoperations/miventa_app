import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class Circuito extends Model {
  Circuito({
    id,
    this.fecha,
    this.codigoCircuito,
    this.nombreCircuito,
    this.cantidad,
    this.visitado = 0,
    this.segmentoPdv,
  }) : super(id);

  DateTime? fecha;
  int? codigoCircuito;
  String? nombreCircuito;
  int? cantidad;
  int? visitado;
  String? segmentoPdv;

  factory Circuito.fromJson(Map<String, dynamic> json) => Circuito(
        fecha: DateFormat('dd-MM-yyyy').parse(json["fecha"].toString()),
        codigoCircuito: json["codigoCircuito"],
        nombreCircuito: json["nombreCircuito"],
        cantidad: json["cantidad"],
        visitado: json["visitado"] ?? 0,
        segmentoPdv: json["segmentoPdv"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "fecha": DateFormat('dd-MM-yyyy').format(fecha!),
        "codigocircuito": codigoCircuito,
        "nombrecircuito": nombreCircuito,
        "cantidad": cantidad,
        "visitado": visitado ?? 0,
        "segmentoPdv": segmentoPdv,
      };
}
