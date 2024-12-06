part of 'inventario_reasignado_bloc.dart';

class InventarioReasignadoState extends Equatable {
  final bool cargando;
  final List<String> tipos;
  final List<ProductoTangibleReasignacion> inventarioReasignado;
  final List<ProductoTangibleReasignacion> inventarioReasignadoFiltrado;
  final String tipoSeleccionado;
  final List<TipoTangibleReasignacionInfo> tipoInfoReasignacion;
  final String modeloSeleccionado;

  const InventarioReasignadoState(
      {this.cargando = false,
      this.tipos = const [],
      this.inventarioReasignado = const [],
      this.inventarioReasignadoFiltrado = const [],
      this.tipoSeleccionado = "",
      this.tipoInfoReasignacion = const [],
      this.modeloSeleccionado = ""});

  InventarioReasignadoState copyWith(
          {bool? cargando,
          List<String>? tipos,
          List<ProductoTangibleReasignacion>? inventarioReasignado,
          List<ProductoTangibleReasignacion>? inventarioReasignadoFiltrado,
          String? tipoSeleccionado,
          List<TipoTangibleReasignacionInfo>? tipoInfoReasignacion,
          String? modeloSeleccionado}) =>
      InventarioReasignadoState(
          cargando: cargando ?? this.cargando,
          tipos: tipos ?? this.tipos,
          inventarioReasignado:
              inventarioReasignado ?? this.inventarioReasignado,
          inventarioReasignadoFiltrado:
              inventarioReasignadoFiltrado ?? this.inventarioReasignadoFiltrado,
          tipoSeleccionado: tipoSeleccionado ?? this.tipoSeleccionado,
          tipoInfoReasignacion: tipoInfoReasignacion ?? this.tipoInfoReasignacion,
          modeloSeleccionado: modeloSeleccionado ?? this.modeloSeleccionado);

  @override
  List<Object> get props => [
        tipos,
        cargando,
        inventarioReasignado,
        tipoSeleccionado,
        inventarioReasignadoFiltrado,
        tipoInfoReasignacion,
        modeloSeleccionado
      ];
}
