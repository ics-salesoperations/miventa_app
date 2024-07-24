part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<List<Tracking>> myLocationHistory;
  DateTime? trackingStart;
  final bool actualizandoTracking;

  LocationState({
    this.followingUser = false,
    this.lastKnownLocation,
    myLocationHistory,
    this.trackingStart,
    this.actualizandoTracking = false,
  }) : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<List<Tracking>>? myLocationHistory,
    DateTime? trackingStart,
    bool? actualizandoTracking,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
        trackingStart: trackingStart ?? this.trackingStart,
        actualizandoTracking: actualizandoTracking ?? this.actualizandoTracking,
      );

  @override
  List<Object?> get props => [
        followingUser,
        lastKnownLocation,
        myLocationHistory,
        trackingStart,
        actualizandoTracking,
      ];
}
