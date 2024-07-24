part of 'actualizar_bloc.dart';

class ActualizarState extends Equatable {
  final List<Tabla> tablas;
  final bool actualizandoForms;
  final bool actualizandoPlanning;
  final bool actualizandoSolicitudes;
  final bool actualizandoModelos;
  final bool actualizandoTangible;
  final String mensaje;

  const ActualizarState({
    this.actualizandoForms = false,
    this.actualizandoPlanning = false,
    this.actualizandoSolicitudes = false,
    this.actualizandoModelos = false,
    this.actualizandoTangible = false,
    this.mensaje = "",
    this.tablas = const [],
  });

  ActualizarState copyWith({
    bool? actualizandoForms,
    bool? actualizandoPlanning,
    bool? actualizandoSolicitudes,
    bool? actualizandoModelos,
    bool? actualizandoTangible,
    String? mensaje,
    List<Tabla>? tablas,
  }) =>
      ActualizarState(
        actualizandoForms: actualizandoForms ?? this.actualizandoForms,
        actualizandoPlanning: actualizandoPlanning ?? this.actualizandoPlanning,
        actualizandoSolicitudes:
            actualizandoSolicitudes ?? this.actualizandoSolicitudes,
        actualizandoModelos: actualizandoModelos ?? this.actualizandoModelos,
        actualizandoTangible: actualizandoTangible ?? this.actualizandoTangible,
        mensaje: mensaje ?? this.mensaje,
        tablas: tablas ?? this.tablas,
      );

  @override
  List<Object> get props => [
        actualizandoForms,
        actualizandoPlanning,
        actualizandoSolicitudes,
        actualizandoModelos,
        actualizandoTangible,
        mensaje,
        tablas,
      ];
}
