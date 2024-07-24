import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class Segmento extends Model {
  Segmento({
    id,
    this.fecha,
    this.codigoCircuito,
    this.nombreCircuito,
    this.segmento,
    this.cantidad,
    this.pendiente,
  }) : super(id);
  DateTime? fecha;
  int? codigoCircuito;
  String? nombreCircuito;
  String? segmento;
  int? cantidad;
  int? pendiente;

  factory Segmento.fromJson(Map<String, dynamic> json) => Segmento(
        id: json["id"],
        fecha: DateFormat('dd-MMM-yyyy').parse(json["fecha"]),
        codigoCircuito: json["codigoCircuito"],
        nombreCircuito: json["nombreCircuito"],
        segmento: json["segmento"],
        cantidad: json["cantidad"],
        pendiente: json["pendiente"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": DateFormat('dd-MMM-yyyy').format(fecha!),
        "codigoCircuito": codigoCircuito,
        "nombrecircuito": nombreCircuito,
        "segmento": segmento,
        "cantidad": cantidad,
        "pendiente": pendiente,
      };
}
