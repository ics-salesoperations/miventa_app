import 'package:miventa_app/models/model.dart';

class Tracking extends Model {
  Tracking({
    id,
    this.idTracking,
    this.usuario,
    this.fecha,
    this.fechaInicio,
    this.fechaFin,
    this.latitud,
    this.longitud,
  }) : super(id);

  String? idTracking;
  String? usuario;
  DateTime? fecha;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  double? latitud;
  double? longitud;

  Tracking copyWith({
    int? id,
    String? idTracking,
    String? usuario,
    DateTime? fecha,
    DateTime? fechaInicio,
    DateTime? fechaFin,
    double? latitud,
    double? longitud,
  }) =>
      Tracking(
        id: id ?? this.id,
        idTracking: idTracking ?? this.idTracking,
        usuario: usuario ?? this.usuario,
        fecha: fecha ?? this.fecha,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin ?? this.fechaFin,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
      );

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        idTracking: json["idTracking"],
        usuario: json["usuario"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        fechaInicio: json["fechaInicio"] == null
            ? null
            : DateTime.parse(json["fechaInicio"]),
        fechaFin:
            json["fechaFin"] == null ? null : DateTime.parse(json["fechaFin"]),
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "idTracking": idTracking,
        "usuario": usuario,
        "fecha": fecha != null ? fecha!.toIso8601String() : null,
        "fechaInicio":
            fechaInicio != null ? fechaInicio!.toIso8601String() : null,
        "fechaFin": fecha != null ? fechaFin!.toIso8601String() : null,
        "latitud": latitud,
        "longitud": longitud,
      };
}
