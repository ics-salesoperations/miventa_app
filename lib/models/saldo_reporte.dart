import 'package:intl/intl.dart';
// 1. Modelo de datos para el resumen
class SaldoReporte {

  final DateTime fechaHoraTfr;
  final String nombrePdv;
  final String toMovil;
  final String montoTfr;
  final String saldoPdv;
  final String saldoVendedor;

  SaldoReporte({
    required this.fechaHoraTfr,
    required this.nombrePdv,
    required this.toMovil,
    required this.montoTfr,
    required this.saldoPdv,
    required this.saldoVendedor
  });

  factory SaldoReporte.fromMap(Map<String, dynamic> m) {
    return SaldoReporte(
      fechaHoraTfr:DateFormat('yyyy-MM-dd HH:mm:ss').parse(m["fechaHoraTfr"]),
      nombrePdv: m['nombrePdv'] as String,
      toMovil: m['toMovil'].toString() as String,
      montoTfr: m['montoTfr'].toString() as String,
      saldoPdv: m['saldoPdv'].toString() as String,
      saldoVendedor: m['saldoVendedor'].toString() as String,
    );
  }
}