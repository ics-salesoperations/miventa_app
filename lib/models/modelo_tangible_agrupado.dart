// 1. Modelo de datos para el resumen
class ResumenModelo {
  final String modelo;
  final int total;
  final double precio;

  ResumenModelo({
    required this.modelo,
    required this.total,
    required this.precio
  });

  factory ResumenModelo.fromMap(Map<String, dynamic> m) {
    return ResumenModelo(
      modelo: m['modelo'] as String,
      total: m['total'] as int,
      precio: m['precio'] as double
    );
  }
}