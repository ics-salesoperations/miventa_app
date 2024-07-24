import 'package:miventa_app/models/model.dart';

class Sucursal extends Model {
  Sucursal({
    id,
    required this.idSucursal,
    required this.nombreSucursal,
  }) : super(id);

  String idSucursal;
  String nombreSucursal;

  factory Sucursal.fromJson(Map<String, dynamic> json) => Sucursal(
        idSucursal: json["idSucursal"].toString(),
        nombreSucursal: json["nombreSucursal"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "idSucursal": idSucursal,
        "nombreSucursal": nombreSucursal,
      };
}
