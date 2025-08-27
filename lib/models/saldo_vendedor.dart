import 'package:intl/intl.dart';
import 'package:miventa_app/models/model.dart';

class SaldoVendedor extends Model {
  static String table = 'saldo';

  SaldoVendedor({
    id,
    this.fechaHoraTfr,
    this.nombreDms,
    this.saldoVendedor,
    this.fromMovil,
    this.toMovil,
    this.canal,
    this.idPdv,
    this.nombrePdv,
    this.montoTfr,
    this.saldoPdv,
    this.actualizado,
  }) : super(id);

  DateTime? fechaHoraTfr;
  String? nombreDms;
  String? saldoVendedor;
  String? fromMovil;
  String? toMovil;
  String? canal;
  String? idPdv;
  String? nombrePdv;
  String? montoTfr;
  String? saldoPdv;
  DateTime? actualizado;

  SaldoVendedor copyWith(
          {int? id,
          DateTime? fechaHoraTrf,
          String? nombreDms,
          String? saldoVendedor,
          String? fromMovil,
          String? toMovil,
          String? canal,
          String? idPdv,
          String? nombrePdv,
          String? montoTfr,
          String? saldoPdv,
          DateTime? actualizado,
          }) =>
      SaldoVendedor(
        id: id ?? this.id,
        fechaHoraTfr: fechaHoraTfr ?? this.fechaHoraTfr,
        nombreDms: nombreDms ?? this.nombreDms,
        saldoVendedor: saldoVendedor ?? this.saldoVendedor,
        fromMovil: fromMovil ?? this.fromMovil,
        toMovil: toMovil ?? this.toMovil,
        canal: canal ?? this.canal,
        idPdv: idPdv ?? this.idPdv,
        nombrePdv: nombrePdv ?? this.nombrePdv,
        montoTfr: montoTfr ?? this.montoTfr,
        saldoPdv: saldoPdv ?? this.saldoPdv,
        actualizado: actualizado ?? this.actualizado,
      );

  factory SaldoVendedor.fromJson(Map<String, dynamic> json) {
    return SaldoVendedor(
      id: json["id"],
      fechaHoraTfr: json["fechaHoraTfr"] == null
          ? null
          : DateFormat('yyyy-MM-dd HH:mm:ss').parse(json["fechaHoraTfr"]),
      nombreDms: json["nombreDms"],
      saldoVendedor: json["saldoVendedor"].toString(),
      fromMovil: json["fromMovil"],
      toMovil: json["toMovil"],
      canal: json["canal"] ?? 'No encontrado',
      idPdv: json["idPdv"].toString() == 'null' ? '0' : json["idPdv"].toString(),
      nombrePdv: json["nombrePdv"] ?? 'No encontrado',
      montoTfr: json["montoTfr"].toString(),
      saldoPdv: json["saldoPdv"].toString(),
      actualizado: json["actualizado"] == null
          ? null
          : DateFormat('yyyy-MM-dd HH:mm:ss').parse(json["actualizado"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fechaHoraTfr":
        fechaHoraTfr != null
        ? DateFormat('dd-MM-yyyy HH:mm:ss').format(fechaHoraTfr!)
        : null,
      "saldoVendedor": saldoVendedor,
      "fromMovil": fromMovil,
      "toMovil": toMovil,
      "canal": canal,
      "idPdv": idPdv,
      "nombrePdv": nombrePdv,
      "montoTfr": montoTfr,
      "saldoPdv": saldoPdv,
      "actualizado":
        actualizado != null
        ? DateFormat('dd-MM-yyyy HH:mm:ss').format(actualizado!)
        : null,
    };
  }
}
