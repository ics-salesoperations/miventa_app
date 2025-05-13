part of 'actualizar_bloc.dart';

abstract class ActualizarEvent extends Equatable {
  const ActualizarEvent();

  @override
  List<Object> get props => [];
}

class OnActualizarFormulariosEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoForms;
  final List<Tabla> tablas;

  const OnActualizarFormulariosEvent({
    required this.actualizandoForms,
    required this.mensaje,
    required this.tablas,
  });
}

class OnGetTablasEvent extends ActualizarEvent {
  final List<Tabla> tablas;

  const OnGetTablasEvent({
    required this.tablas,
  });
}

class OnActualizarPlanningEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoPlanning;
  final List<Tabla> tablas;

  const OnActualizarPlanningEvent({
    required this.actualizandoPlanning,
    required this.mensaje,
    required this.tablas,
  });
}

class OnActualizarModelosEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoModelos;
  final List<Tabla> tablas;

  const OnActualizarModelosEvent({
    required this.actualizandoModelos,
    required this.mensaje,
    required this.tablas,
  });
}

class OnActualizarTangiblesEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoTangible;
  final List<Tabla> tablas;

  const OnActualizarTangiblesEvent({
    required this.actualizandoTangible,
    required this.mensaje,
    required this.tablas,
  });
}

class OnActualizarTangiblesReasignacionEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoTangible;
  final String tabla;

  const OnActualizarTangiblesReasignacionEvent({
    required this.actualizandoTangible,
    required this.mensaje,
    required this.tabla,
  });
}

class OnActualizarSolicitudesEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoSolicitudes;

  const OnActualizarSolicitudesEvent({
    required this.actualizandoSolicitudes,
    required this.mensaje,
  });
}

class OnActualizarIncentivosPdvEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoIncentivosPdv;

  const OnActualizarIncentivosPdvEvent({
    required this.actualizandoIncentivosPdv,
    required this.mensaje,
  });
}

class OnActualizarIndicadoresVendedorEvent extends ActualizarEvent {
  final String mensaje;
  final bool actualizandoIndicadoresVendedor;
  final List<Tabla> tablas;

  const OnActualizarIndicadoresVendedorEvent({
    required this.actualizandoIndicadoresVendedor,
    required this.mensaje,
    required this.tablas,
  });
}