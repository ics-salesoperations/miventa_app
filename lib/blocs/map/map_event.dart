part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  final BuildContext context;

  const OnMapInitializedEvent(this.controller, this.context);
}

class OnStartFollowingUserEvent extends MapEvent {}

class OnStopFollowingUserEvent extends MapEvent {}

class OnUpdateUserPolylinesEvent extends MapEvent {}

class OnToggleUserRoute extends MapEvent {}

class OnToggleShowMarkers extends MapEvent {}

class OnDisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const OnDisplayPolylinesEvent(
    this.polylines,
    this.markers,
  );
}

class OnUpdateCircuitosSeleccionadosEvent extends MapEvent {
  final List<Circuito> circuitosSeleccionados;

  const OnUpdateCircuitosSeleccionadosEvent({
    required this.circuitosSeleccionados,
  });
}

class OnUpdatePDVsMap extends MapEvent {
  final List<Planning> pdvs;

  const OnUpdatePDVsMap(this.pdvs);
}
