part of 'planning_bloc.dart';

class PlanningState extends Equatable {
  final List<Circuito> circuitos;
  final List<Circuito> segmentado;
  final bool circuitosActualizados;

  const PlanningState({
    this.circuitos = const [],
    this.circuitosActualizados = false,
    this.segmentado = const [],
  });

  PlanningState copyWith({
    List<Circuito>? circuitos,
    bool? circuitosActualizados,
    List<Circuito>? segmentado,
  }) =>
      PlanningState(
        circuitos: circuitos ?? this.circuitos,
        circuitosActualizados:
            circuitosActualizados ?? this.circuitosActualizados,
        segmentado: segmentado ?? this.segmentado,
      );

  @override
  List<Object> get props => [
        circuitos,
        circuitosActualizados,
        segmentado,
      ];
}
