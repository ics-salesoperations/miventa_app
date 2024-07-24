part of 'speed_test_bloc.dart';

class SpeedTestState extends Equatable {
  final double upload;
  final double download;
  final String mensaje;
  final String tipo;
  final bool ejecutando;

  const SpeedTestState({
    required this.upload,
    required this.download,
    this.mensaje = "",
    this.tipo = "BAJADA",
    this.ejecutando = false,
  });

  SpeedTestState copyWith({
    double? upload,
    double? download,
    String? mensaje,
    String? tipo,
    bool? ejecutando,
  }) =>
      SpeedTestState(
        upload: upload ?? this.upload,
        download: download ?? this.download,
        mensaje: mensaje ?? this.mensaje,
        tipo: tipo ?? this.tipo,
        ejecutando: ejecutando ?? this.ejecutando,
      );

  @override
  List<Object> get props => [
        upload,
        download,
        mensaje,
        tipo,
        ejecutando,
      ];

  @override
  String toString() {
    return '{ networkInfo: $upload }';
  }
}
