import 'package:miventa_app/models/model.dart';

class TrackingDet extends Model {
  //nombre de tabla en base de datos local
  static String table = "tracking_det";

  TrackingDet({
    id,
    this.idTracking,
    this.fecha,
    this.latitude,
    this.longitude,
  }) : super(id);

  String? idTracking;
  DateTime? fecha;
  double? latitude;
  double? longitude;

  TrackingDet copyWith({
    int? id,
    String? idTracking,
    DateTime? fecha,
    double? latitude,
    double? longitude,
  }) =>
      TrackingDet(
        id: id ?? this.id,
        idTracking: idTracking ?? this.idTracking,
        fecha: fecha ?? this.fecha,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory TrackingDet.fromJson(Map<String, dynamic> json) => TrackingDet(
        id: json["id"],
        idTracking: json["idTracking"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        latitude: json["latitude"] == null ? 0 : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? 0 : json["longitude"].toDouble(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "idTracking": idTracking,
        "fecha": fecha != null ? fecha!.toIso8601String() : null,
        "latitude": latitude,
        "longitude": longitude,
      };
}
