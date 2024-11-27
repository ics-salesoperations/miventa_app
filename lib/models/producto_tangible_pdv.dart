import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class ProductoTangibleReasignacion extends Model {
  static String table = 'tangible_reasignacion';

  ProductoTangibleReasignacion({
    id,
    this.idPdv,
    this.producto,
    this.modelo,
    this.descModelo,
    this.serie,
    this.fechaAsignacion,
    this.fechaVenta,
    this.asignado = 0,
    this.confirmado = 0,
    this.enviado = 0,
    this.idVisita,
    this.descartado = 0,
  }) : super(id);
  int? idPdv;
  String? producto;
  String? modelo;
  String? descModelo;
  String? serie;
  DateTime? fechaAsignacion;
  DateTime? fechaVenta;
  int asignado;
  int confirmado;
  int enviado;
  String? idVisita;
  int descartado;

  ProductoTangibleReasignacion copyWith({
    int? id,
    int? idPdv,
    String? tangible,
    String? modelo,
    String? descModelo,
    String? serie,
    DateTime? fechaAsignacion,
    DateTime? fechaVenta,
    int? asignado,
    int? confirmado,
    int? enviado,
    String? idVisita,
    int? descartado,
  }) =>
      ProductoTangibleReasignacion(
        id: id ?? this.id,
        idPdv: idPdv ?? this.idPdv,
        producto: tangible ?? producto,
        modelo: modelo ?? this.modelo,
        descModelo: descModelo ?? this.descModelo,
        serie: serie ?? this.serie,
        fechaAsignacion: fechaAsignacion ?? this.fechaAsignacion,
        fechaVenta: fechaVenta ?? this.fechaVenta,
        asignado: asignado ?? this.asignado,
        confirmado: confirmado ?? this.confirmado,
        enviado: enviado ?? this.enviado,
        idVisita: idVisita ?? this.idVisita,
        descartado: descartado ?? this.descartado,
      );

  factory ProductoTangibleReasignacion.fromMap(Map<String, dynamic> json) =>
      ProductoTangibleReasignacion(
        id: json["id"],
        idPdv: json["idPdv"] != null ? int.parse(json["idPdv"].toString()) : 0,
        producto: json["tangible"],
        modelo: json["modelo"],
        descModelo: json["descModelo"],
        serie: json["serie"].toString(),
        fechaAsignacion: json["fechaAsignacion"] != null
            ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                json["fechaAsignacion"].toString(),
              )
            : null,
        fechaVenta: json["fechaVenta"] != null
            ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                json["fechaVenta"].toString(),
              )
            : null,
        asignado: json["asignado"] ?? 0,
        confirmado: json["confirmado"] ?? 0,
        enviado: json["enviado"] ?? 0,
        idVisita: json["idVisita"],
        descartado: json["descartado"] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idPdv": idPdv,
        "tangible": producto,
        "modelo": modelo,
        "descModelo": descModelo,
        "serie": serie,
        "fechaAsignacion": fechaAsignacion != null
            ? DateFormat('dd-MM-yyyy HH:mm:ss').format(fechaAsignacion!)
            : null,
        "fechaVenta": fechaVenta != null
            ? DateFormat('dd-MM-yyyy HH:mm:ss').format(fechaVenta!)
            : null,
        "asignado": asignado,
        "confirmado": confirmado,
        "enviado": enviado,
        "idVisita": idVisita,
        "descartado": descartado,
      };
}

// Ejemplo de cómo manejar la lista de elementos
List<ProductoTangibleReasignacion> parseProductosTangibleReasignacion(
    List<dynamic> jsonList) {
  return jsonList
      .map((json) => ProductoTangibleReasignacion.fromMap(json))
      .toList();
}
