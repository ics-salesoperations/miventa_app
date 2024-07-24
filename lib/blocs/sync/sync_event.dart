part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class OnCargarResumenEvent extends SyncEvent {
  final List<ResumenSincronizar> resSincronizar;
  final bool actualizandoResumen;
  final String mensaje;

  const OnCargarResumenEvent({
    required this.resSincronizar,
    required this.actualizandoResumen,
    required this.mensaje,
  });
}

class OnCargarDetalleEvent extends SyncEvent {
  final List<DetalleAnswer> respDetalleList;
  final bool actualizandoDetalle;
  final String mensaje;

  const OnCargarDetalleEvent({
    required this.respDetalleList,
    required this.actualizandoDetalle,
    required this.mensaje,
  });
}

class OnBorrarSincronizadosEvent extends SyncEvent {
  final bool borrando;
  final String mensaje;

  const OnBorrarSincronizadosEvent({
    required this.borrando,
    required this.mensaje,
  });
}

class OnSincronizandoEvent extends SyncEvent {
  final bool sincronizando;
  final String mensaje;

  const OnSincronizandoEvent({
    required this.sincronizando,
    required this.mensaje,
  });
}

class OnCargarDetalleVisitaEvent extends SyncEvent {
  final List<ProductoTangible> detalleVisita;

  const OnCargarDetalleVisitaEvent({
    required this.detalleVisita,
  });
}
