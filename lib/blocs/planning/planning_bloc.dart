import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/db_service.dart';

part 'planning_event.dart';
part 'planning_state.dart';

class PlanningBloc extends Bloc<PlanningEvent, PlanningState> {
  final DBService _dbService = DBService();

  PlanningBloc() : super(const PlanningState()) {
    on<OnCargarCircuitosPlanningEvent>((event, emit) {
      emit(
        state.copyWith(
          circuitosActualizados: event.circuitosActualizados,
          circuitos: event.circuitos,
          segmentado: event.segmentado,
        ),
      );
    });
  }

  Future<void> init() async {
    add(
      const OnCargarCircuitosPlanningEvent(
        circuitosActualizados: false,
        circuitos: [],
        segmentado: [],
      ),
    );
    final circuitosPlanning = await getPlanningCircuitos();
    final segmentadoPlanning = await getPlanningSegmentado();

    add(OnCargarCircuitosPlanningEvent(
      circuitosActualizados: true,
      circuitos: circuitosPlanning,
      segmentado: segmentadoPlanning,
    ));
  }

  Future<List<Circuito>> getPlanningCircuitos() async {
    try {
      final circuitos = await _dbService
          .leerPlanningCircuitos(); //await LocalDatabase.instance.leerPlanningCircuitos();
      return circuitos;
    } catch (e) {
      return <Circuito>[];
    }
  }

  Future<List<Circuito>> getPlanningSegmentado() async {
    try {
      final circuitos = await _dbService.leerPlanningSegmentado();
      return circuitos;
    } catch (e) {
      return <Circuito>[];
    }
  }
}
