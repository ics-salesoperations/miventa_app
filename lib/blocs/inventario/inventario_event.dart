part of 'inventario_bloc.dart';

abstract class InventarioEvent extends Equatable {
  const InventarioEvent();

  @override
  List<Object> get props => [];
}

class OnActualizarInventarioEvent extends InventarioEvent {
  final bool cargando;
  const OnActualizarInventarioEvent({
    required this.cargando,
  });
}

class OnCargarInventarioEvent extends InventarioEvent {
  final bool cargando;
  final List<String> tipos;
  final List<ProductoTangible> inventario;

  const OnCargarInventarioEvent({
    required this.cargando,
    required this.tipos,
    required this.inventario,
  });
}

class OnFiltrarTipoEvent extends InventarioEvent {
  final bool cargando;
  final String tipoSeleccionado;
  final List<ProductoTangible> inventarioFiltrado;
  final List<TipoTangibleInfo> tipoInfo;
  final String? modeloSeleccionado;

  const OnFiltrarTipoEvent({
    required this.cargando,
    required this.tipoSeleccionado,
    required this.inventarioFiltrado,
    required this.tipoInfo,
    required this.modeloSeleccionado
  });
}
