import 'package:miventa_app/models/model.dart';

class TrackingHead extends Model {
  //nombre de tabla en base de datos local
  static String table = "tracking_head";

  TrackingHead({
    id,
    this.idTracking,
    this.usuario,
    this.fechaInicio,
    this.fechaFin,
  }) : super(id);

  String? idTracking;
  String? usuario;
  DateTime? fechaInicio;
  DateTime? fechaFin;

  TrackingHead copyWith({
    int? id,
    String? idTracking,
    String? usuario,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) =>
      TrackingHead(
        id: id ?? this.id,
        idTracking: idTracking ?? this.idTracking,
        usuario: usuario ?? this.usuario,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaFin: fechaFin ?? this.fechaFin,
      );

  factory TrackingHead.fromJson(Map<String, dynamic> json) => TrackingHead(
        id: json["id"],
        idTracking: json["idTracking"],
        usuario: json["usuario"],
        fechaInicio: json["fechaInicio"] == null
            ? null
            : DateTime.parse(json["fechaInicio"]),
        fechaFin:
            json["fechaFin"] == null ? null : DateTime.parse(json["fechaFin"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idTracking": idTracking,
        "usuario": usuario,
        "fechaInicio":
            fechaInicio != null ? fechaInicio!.toIso8601String() : null,
        "fechaFin": fechaFin != null ? fechaFin!.toIso8601String() : null,
      };
}
