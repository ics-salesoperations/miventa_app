part of 'planning_bloc.dart';

abstract class PlanningEvent extends Equatable {
  const PlanningEvent();

  @override
  List<Object> get props => [];
}

class OnCargarCircuitosPlanningEvent extends PlanningEvent {
  final List<Circuito> circuitos;
  final bool circuitosActualizados;
  final List<Circuito> segmentado;

  const OnCargarCircuitosPlanningEvent({
    required this.circuitos,
    required this.circuitosActualizados,
    required this.segmentado,
  });
}
