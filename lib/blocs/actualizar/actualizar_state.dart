part of 'actualizar_bloc.dart';

class ActualizarState extends Equatable {
  final List<Tabla> tablas;
  final bool actualizandoForms;
  final bool actualizandoPlanning;
  final bool actualizandoSolicitudes;
  final bool actualizandoModelos;
  final bool actualizandoTangible;
  final bool actualizandoIncentivosPdv;
  final bool actualizandoIndicadoresVendedor;
  final bool actualizandoSaldoVendedor;
  final String mensaje;
  final String tabla;

  const ActualizarState({
    this.actualizandoForms = false,
    this.actualizandoPlanning = false,
    this.actualizandoSolicitudes = false,
    this.actualizandoModelos = false,
    this.actualizandoTangible = false,
    this.actualizandoIncentivosPdv = false,
    this.actualizandoIndicadoresVendedor = false,
    this.actualizandoSaldoVendedor = false,
    this.mensaje = "",
    this.tablas = const [],
    this.tabla = "",
  });

  ActualizarState copyWith({
    bool? actualizandoForms,
    bool? actualizandoPlanning,
    bool? actualizandoSolicitudes,
    bool? actualizandoModelos,
    bool? actualizandoTangible,
    bool? actualizandoIncentivosPdv,
    bool? actualizandoIndicadoresVendedor,
    bool? actualizandoSaldoVendedor,
    String? mensaje,
    List<Tabla>? tablas,
    String? tabla,
  }) =>
      ActualizarState(
        actualizandoForms: actualizandoForms ?? this.actualizandoForms,
        actualizandoPlanning: actualizandoPlanning ?? this.actualizandoPlanning,
        actualizandoSolicitudes:
            actualizandoSolicitudes ?? this.actualizandoSolicitudes,
        actualizandoModelos: actualizandoModelos ?? this.actualizandoModelos,
        actualizandoTangible: actualizandoTangible ?? this.actualizandoTangible,
        actualizandoIncentivosPdv:
            actualizandoIncentivosPdv ?? this.actualizandoIncentivosPdv,
        actualizandoIndicadoresVendedor:
            actualizandoIndicadoresVendedor ?? this.actualizandoIndicadoresVendedor,
        actualizandoSaldoVendedor:
            actualizandoSaldoVendedor ?? this.actualizandoSaldoVendedor,
        mensaje: mensaje ?? this.mensaje,
        tablas: tablas ?? this.tablas,
        tabla: tabla ?? this.tabla,
      );

  @override
  List<Object> get props => [
        actualizandoForms,
        actualizandoPlanning,
        actualizandoSolicitudes,
        actualizandoModelos,
        actualizandoTangible,
        actualizandoIncentivosPdv,
        actualizandoIndicadoresVendedor,
        actualizandoSaldoVendedor,
        mensaje,
        tablas,
        tabla,
      ];
}
