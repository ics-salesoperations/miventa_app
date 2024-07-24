// ignore_for_file: non_constant_identifier_names

part of 'network_info_bloc.dart';

abstract class NetworkInfoEvent extends Equatable {
  const NetworkInfoEvent();

  @override
  List<Object> get props => [];
}

class ActualizarNuevaInfoEvent extends NetworkInfoEvent {
  final NetworkInfo info;
  final bool actualizado;

  const ActualizarNuevaInfoEvent({
    required this.info,
    required this.actualizado,
  });
}

class ToogleActivadoEvent extends NetworkInfoEvent {
  final bool activado;

  const ToogleActivadoEvent({
    required this.activado,
  });
}

class OnGuardandoEvent extends NetworkInfoEvent {
  final bool guardando;
  final String mensaje;

  const OnGuardandoEvent({
    required this.guardando,
    required this.mensaje,
  });
}

class OnEnviandoEvent extends NetworkInfoEvent {
  final bool enviando;
  final String mensaje;

  const OnEnviandoEvent({
    required this.enviando,
    required this.mensaje,
  });
}
