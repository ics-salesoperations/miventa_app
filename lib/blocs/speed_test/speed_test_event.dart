// ignore_for_file: non_constant_identifier_names

part of 'speed_test_bloc.dart';

abstract class SpeedTestEvent extends Equatable {
  const SpeedTestEvent();

  @override
  List<Object> get props => [];
}

class OnIniciarSpeedTest extends SpeedTestEvent {
  final double download;
  final double upload;
  final String mensaje;
  final String tipo;
  final bool ejecutando;

  const OnIniciarSpeedTest({
    required this.download,
    required this.upload,
    required this.mensaje,
    required this.tipo,
    required this.ejecutando,
  });
}
