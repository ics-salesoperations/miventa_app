import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/services/db_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;
  final DBService _db = DBService();

  ReceivePort port = ReceivePort();

  LocationBloc() : super(LocationState()) {
    on<OnStartFollowingUser>(
      (event, emit) {
        emit(state.copyWith(
          followingUser: true,
        ));
      },
    );
    on<OnStopFollowingUser>((event, emit) {
      emit(state.copyWith(followingUser: false));
    });
    on<OnActualizarReporteTrackingEvent>((event, emit) {
      emit(
        state.copyWith(
          actualizandoTracking: event.actualizandoTracking,
          myLocationHistory: event.tracking,
        ),
      );
    });
    on<OnNewUserLocationEvent>((event, emit) {
      emit(
        state.copyWith(
          lastKnownLocation: event.newLocation,
        ),
      );
    });
  }

  Future<Position> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    add(
      OnNewUserLocationEvent(
        newLocation: LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    );
    return position;
  }

  Future actualizarReporteTracking({
    required DateTime start,
    required DateTime end,
  }) async {
    List<List<Tracking>> listTracking = [];

    add(
      const OnActualizarReporteTrackingEvent(
        actualizandoTracking: false,
        tracking: [],
      ),
    );

    final listTrackingResumen = await _db.leerTrackingResumen(
      start: start,
      end: end,
    );

    for (var id in listTrackingResumen) {
      final ruta =
          await _db.leerTracking(start: start, end: end, idTracking: id);

      listTracking.add(ruta);
    }

    add(
      OnActualizarReporteTrackingEvent(
        actualizandoTracking: false,
        tracking: listTracking,
      ),
    );
  }

  void startFollowingUser() async {
    add(OnStartFollowingUser());
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(
        OnNewUserLocationEvent(
          newLocation: LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
