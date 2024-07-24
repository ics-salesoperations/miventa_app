part of 'network_info_bloc.dart';

class NetworkInfoState extends Equatable {
  final bool actualizado;
  final bool activado;
  final NetworkInfo? info;
  final bool guardando;
  final bool enviando;
  final String mensaje;

  const NetworkInfoState({
    required this.actualizado,
    this.info,
    required this.activado,
    required this.guardando,
    required this.enviando,
    this.mensaje = "",
  });

  NetworkInfoState copyWith({
    bool? actualizado,
    NetworkInfo? info,
    bool? activado,
    bool? guardando,
    bool? enviando,
    String? mensaje,
  }) =>
      NetworkInfoState(
        info: info ?? this.info,
        actualizado: actualizado ?? this.actualizado,
        activado: activado ?? this.activado,
        guardando: guardando ?? this.guardando,
        enviando: enviando ?? this.enviando,
        mensaje: mensaje ?? this.mensaje,
      );

  @override
  List<Object> get props => [actualizado, activado, enviando, mensaje];

  @override
  String toString() {
    return '{ networkInfo: $info }';
  }
}
