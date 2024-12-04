// import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class SolicitudesGer extends Model {
  static String table = 'gerentes';

  SolicitudesGer({
    id,
    this.usuario,
    this.idDealer,
    this.idSucursal,
  }) : super(id);
  String? usuario;
  int? idDealer;
  int? idSucursal;

  SolicitudesGer copyWith({
    String? usuario,
    int? idDealer,
    int? idSucursal,
  }) =>
      SolicitudesGer(
        usuario: usuario ?? this.usuario,
        idDealer: idDealer ?? this.idDealer,
        idSucursal: idSucursal ?? this.idSucursal,
      );

  factory SolicitudesGer.fromMap(Map<String, dynamic> json) => SolicitudesGer(
        usuario: json["usuario"].toString(),
        idDealer: int.parse(json["idDealer"].toString()),
        idSucursal: int.parse(json["idSucursal"].toString()),
      );

  @override
  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "idDealer": idDealer,
        "idSucursal": idSucursal,
      };
}
