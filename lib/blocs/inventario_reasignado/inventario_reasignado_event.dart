part of 'inventario_reasignado_bloc.dart';

abstract class InventarioReasignadoEvent extends Equatable {
  const InventarioReasignadoEvent();

  @override
  List<Object> get props => [];
}

class OnActualizarInventarioReasignadoEvent extends InventarioReasignadoEvent {
  final bool cargando;
  const OnActualizarInventarioReasignadoEvent({
    required this.cargando,
  });
}

class OnCargarInventarioReasignadoEvent extends InventarioReasignadoEvent {
  final bool cargando;
  final List<String> tipos;
  final List<ProductoTangibleReasignacion> inventarioReasignado;

  const OnCargarInventarioReasignadoEvent({
    required this.cargando,
    required this.tipos,
    required this.inventarioReasignado,
  });
}

class OnFiltrarTipoReasignacionEvent extends InventarioReasignadoEvent {
  final bool cargando;
  final String tipoSeleccionado;
  final List<ProductoTangibleReasignacion> inventarioReasignadoFiltrado;
  final List<TipoTangibleReasignacionInfo> tipoInfoReasignacion;
  final String? modeloSeleccionado;

  const OnFiltrarTipoReasignacionEvent(
      {required this.cargando,
      required this.tipoSeleccionado,
      required this.inventarioReasignadoFiltrado,
      required this.tipoInfoReasignacion,
      required this.modeloSeleccionado});
}
