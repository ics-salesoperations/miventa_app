part of 'sync_bloc.dart';

class SyncState extends Equatable {
  final List<ResumenAnswer> respResumenList;
  final List<DetalleAnswer> respDetalleList;
  final List<ResumenSincronizar> resSincronizar;
  final List<ProductoTangible> detalleVisita;
  final bool actualizandoResumen;
  final bool actualizandoDetalle;
  final bool sincronizando;
  final bool borrando;
  final String mensaje;

  const SyncState({
    this.respResumenList = const [],
    this.respDetalleList = const [],
    this.resSincronizar = const [],
    this.detalleVisita = const [],
    this.actualizandoResumen = false,
    this.actualizandoDetalle = false,
    this.sincronizando = false,
    this.borrando = false,
    this.mensaje = "",
  });

  SyncState copyWith({
    List<ResumenAnswer>? respResumenList,
    List<DetalleAnswer>? respDetalleList,
    List<ResumenSincronizar>? resSincronizar,
    List<ProductoTangible>? detalleVisita,
    bool? actualizandoResumen,
    bool? actualizandoDetalle,
    bool? sincronizando,
    bool? borrando,
    String? mensaje,
  }) =>
      SyncState(
        respResumenList: respResumenList ?? this.respResumenList,
        respDetalleList: respDetalleList ?? this.respDetalleList,
        detalleVisita: detalleVisita ?? this.detalleVisita,
        actualizandoResumen: actualizandoResumen ?? this.actualizandoResumen,
        actualizandoDetalle: actualizandoDetalle ?? this.actualizandoDetalle,
        sincronizando: sincronizando ?? this.sincronizando,
        borrando: borrando ?? this.borrando,
        mensaje: mensaje ?? this.mensaje,
        resSincronizar: resSincronizar ?? this.resSincronizar,
      );

  @override
  List<Object> get props => [
        respResumenList,
        respDetalleList,
        actualizandoResumen,
        actualizandoDetalle,
        sincronizando,
        borrando,
        mensaje,
        resSincronizar,
        detalleVisita,
      ];
}
