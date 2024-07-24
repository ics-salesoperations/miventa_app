part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class onNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const onNewUserLocationEvent({
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

class onStartFollowingUser extends LocationEvent {}

class onStopFollowingUser extends LocationEvent {}
