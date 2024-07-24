import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class ProductoTangible extends Model {
  static String table = 'tangible';

  ProductoTangible({
    id,
    this.producto,
    this.modelo,
    this.descModelo,
    this.serie,
    this.fechaAsignacion,
    this.fechaVenta,
    this.asignado = 0,
    this.confirmado = 0,
    this.enviado = 0,
    this.idPdv,
    this.idVisita,
  }) : super(id);

  String? producto;
  String? modelo;
  String? descModelo;
  String? serie;
  DateTime? fechaAsignacion;
  DateTime? fechaVenta;
  int asignado;
  int confirmado;
  int enviado;
  int? idPdv;
  String? idVisita;

  ProductoTangible copyWith({
    int? id,
    String? tangible,
    String? modelo,
    String? descModelo,
    String? serie,
    DateTime? fechaAsignacion,
    DateTime? fechaVenta,
    int? asignado,
    int? confirmado,
    int? enviado,
    int? idPdv,
    String? idVisita,
  }) =>
      ProductoTangible(
        id: id ?? this.id,
        producto: tangible ?? producto,
        modelo: modelo ?? this.modelo,
        descModelo: descModelo ?? this.descModelo,
        serie: serie ?? this.serie,
        fechaAsignacion: fechaAsignacion ?? this.fechaAsignacion,
        fechaVenta: fechaVenta ?? this.fechaVenta,
        asignado: asignado ?? this.asignado,
        confirmado: confirmado ?? this.confirmado,
        enviado: enviado ?? this.enviado,
        idPdv: idPdv ?? this.idPdv,
        idVisita: idVisita ?? this.idVisita,
      );

  factory ProductoTangible.fromMap(Map<String, dynamic> json) =>
      ProductoTangible(
        id: json["id"],
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
        idPdv: json["idPdv"] ?? 0,
        idVisita: json["idVisita"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
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
        "idPdv": idPdv,
        "idVisita": idVisita,
      };
}
