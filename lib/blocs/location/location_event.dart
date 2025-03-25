part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const OnNewUserLocationEvent({
    required this.newLocation,
  });
}

class OnActualizarReporteTrackingEvent extends LocationEvent {
  final List<List<Tracking>> tracking;
  final bool actualizandoTracking;

  const OnActualizarReporteTrackingEvent({
    required this.tracking,
    required this.actualizandoTracking,
  });
}

class OnStartFollowingUser extends LocationEvent {}

class OnStopFollowingUser extends LocationEvent {}
