import 'package:miventa_app/models/model.dart';

class Tabla extends Model {
  static String table = 'tablas';
  Tabla({
    id,
    this.fechaActualizacion,
    this.tabla,
    this.descripcion,
  }) : super(id);
  DateTime? fechaActualizacion;
  String? tabla;
  String? descripcion;

  factory Tabla.fromMap(Map<String, dynamic> json) => Tabla(
        fechaActualizacion: json["fechaActualizacion"] == null
            ? null
            : DateTime.parse(json["fechaActualizacion"]),
        tabla: json["tabla"],
        descripcion: json["descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "fechaActualizacion": fechaActualizacion != null
            ? fechaActualizacion!.toIso8601String()
            : null,
        "tabla": tabla,
        "descripcion": descripcion,
      };
}
