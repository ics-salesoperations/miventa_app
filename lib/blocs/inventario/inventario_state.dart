part of 'inventario_bloc.dart';

class InventarioState extends Equatable {
  final bool cargando;
  final List<String> tipos;
  final List<ProductoTangible> inventario;
  final List<ProductoTangible> inventarioFiltrado;
  final String tipoSeleccionado;
  final List<TipoTangibleInfo> tipoInfo;
  final String modeloSeleccionado;
  

  const InventarioState({
    this.cargando = false,
    this.tipos = const [],
    this.inventario = const [],
    this.inventarioFiltrado = const [],
    this.tipoSeleccionado = "",
    this.tipoInfo = const [],
    this.modeloSeleccionado = ""
  });

  InventarioState copyWith({
    bool? cargando,
    List<String>? tipos,
    List<ProductoTangible>? inventario,
    List<ProductoTangible>? inventarioFiltrado,
    String? tipoSeleccionado,
    List<TipoTangibleInfo>? tipoInfo,
    String? modeloSeleccionado
  }) =>
      InventarioState(
        cargando: cargando ?? this.cargando,
        tipos: tipos ?? this.tipos,
        inventario: inventario ?? this.inventario,
        inventarioFiltrado: inventarioFiltrado ?? this.inventarioFiltrado,
        tipoSeleccionado: tipoSeleccionado ?? this.tipoSeleccionado,
        tipoInfo: tipoInfo ?? this.tipoInfo,
        modeloSeleccionado: modeloSeleccionado ?? this.modeloSeleccionado
      );

  @override
  List<Object> get props => [
        tipos,
        cargando,
        inventario,
        tipoSeleccionado,
        inventarioFiltrado,
        tipoInfo,
        modeloSeleccionado
      ];
}
