part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final bool showMarkers;
  final List<Planning> pdvs;
  final List<Circuito> circuitosSeleccionados;

  //Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = true,
    this.showMarkers = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    List<Planning>? pdvs,
    List<Circuito>? circuitosSeleccionados,
  })  : polylines = polylines ?? const {},
        pdvs = pdvs ?? const [],
        markers = markers ?? const {},
        circuitosSeleccionados = circuitosSeleccionados ?? const [];

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    bool? showMarkers,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    List<Planning>? pdvs,
    List<Circuito>? circuitosSeleccionados,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        showMarkers: showMarkers ?? this.showMarkers,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
        pdvs: pdvs ?? this.pdvs,
        circuitosSeleccionados:
            circuitosSeleccionados ?? this.circuitosSeleccionados,
      );

  @override
  List<Object> get props => [
        isMapInitialized,
        isFollowingUser,
        polylines,
        showMyRoute,
        showMarkers,
        markers,
        pdvs,
        circuitosSeleccionados,
      ];
}
