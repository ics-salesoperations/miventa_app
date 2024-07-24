import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/blocs/blocs.dart';
import 'package:miventa_app/helpers/helpers.dart';
import 'package:miventa_app/models/models.dart';
import 'package:miventa_app/themes/themes.dart';

import '../../services/services.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;
  BuildContext? _context;

  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<onMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<OnUpdatePDVsMap>((event, emit) {
      return emit(state.copyWith(
        pdvs: event.pdvs,
      ));
    });
    on<OnUpdateUserPolylinesEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
      (event, emit) => emit(
        state.copyWith(
          showMyRoute: !state.showMyRoute,
        ),
      ),
    );
    on<OnToggleShowMarkers>(
      (event, emit) => emit(
        state.copyWith(
          showMarkers: !state.showMarkers,
        ),
      ),
    );
    on<OnDisplayPolylinesEvent>(
      (event, emit) => emit(
        state.copyWith(
          polylines: event.polylines,
          markers: event.markers,
          showMarkers: true,
        ),
      ),
    );
    on<OnUpdateCircuitosSeleccionadosEvent>(
      (event, emit) => emit(
        state.copyWith(
          circuitosSeleccionados: event.circuitosSeleccionados,
        ),
      ),
    );
  }

  void _onInitMap(onMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _context = event.context;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    drawMarkers(context2: _context!);
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;

    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(
    OnUpdateUserPolylinesEvent event,
    Emitter<MapState> emit,
  ) async {
    int cantRow = 0;
    int orden = 0;
    final currentMarkers = <String, Marker>{};
    final currentPolylines = Map<String, Polyline>.from(state.polylines);

    for (var poly in locationBloc.state.myLocationHistory) {
      final puntos = poly.map((e) => LatLng(e.latitud!, e.longitud!)).toList();
      final myRoute = Polyline(
        polylineId: PolylineId(cantRow.toString()),
        color: markerColors[cantRow],
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: puntos,
      );

      currentPolylines[cantRow.toString()] = myRoute;

      //dibujando marcadores
      orden = 1;

      for (final detalle in poly) {
        final marker = await getTrackingMarker(orden);
        final newMarker = Marker(
          anchor: const Offset(0.1, 0.9),
          markerId:
              MarkerId(DateFormat('yyyyMMddHHmmss').format(detalle.fecha!)),
          position: LatLng(detalle.latitud!, detalle.longitud!),
          icon: marker,
          infoWindow: InfoWindow(
            title: DateFormat('dd/MM/yyyy HH:mm:ss').format(detalle.fecha!),
            anchor: const Offset(
              0.05,
              0.75,
            ),
          ),
        );
        currentMarkers[DateFormat('yyyyMMddHHmmss').format(detalle.fecha!)] =
            newMarker;
        orden = orden + 1;
      }

      if (cantRow + 1 == 13) {
        cantRow = 0;
      } else {
        cantRow = cantRow + 1;
      }
    }

    emit(
      state.copyWith(
        polylines: currentPolylines,
        markers: currentMarkers,
      ),
    );
  }

  /*Dibujar Ruta */
  Future drawRoutePolyline(RouteDestination destination, Planning detalle,
      BuildContext context) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: kPrimaryColor,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: destination.points,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble(); //para redondear
    kms = kms / 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    //Custom markers
    //final _startMarker = await getAssetImageMarker();
    //final _endMarker = await getNetworkImageMarker();

    final _startMarker = await getStartCustomMarker(tripDuration, 'Inicio');
    final _endMarker =
        await getEndCustomMarker(kms.toInt(), detalle.nombrePdv!);

    final startMarker = Marker(
      anchor: const Offset(0.1, 0.9),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: _startMarker,
      /*infoWindow: InfoWindow(
        title: "Inicio",
        snippet: "Kms: $kms, duration: $tripDuration",
      ),*/
    );

    final endMarker = Marker(
      anchor: const Offset(0.1, 0.9),
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: _endMarker,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              ) /*BottomMapModal(
                detalle: detalle,
                ctx: context,
              )*/
                  ;
            });
      },
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(OnDisplayPolylinesEvent(currentPolylines, currentMarkers));

    //await Future.delayed(const Duration(milliseconds: 300));

    //_mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  /*Fin Dibujar Ruta */

  /*Dibujar Marcadores */

  Future drawMarkers({required BuildContext context2}) async {
    final mapBloc = BlocProvider.of<MapBloc>(context2);
    final DBService db = DBService();

    List<Planning> _listaPdvs = mapBloc.state.pdvs;

    if (_listaPdvs.isEmpty) {
      _listaPdvs = await db.leerListadoPdv();
    }

    final currentMarkers = <String, Marker>{};

    final currentPosition = await Geolocator.getCurrentPosition();

    for (final detalle in _listaPdvs) {
      final distancia = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        detalle.latitude!,
        detalle.longitude!,
      );

      if (distancia <= 1000 || mapBloc.state.pdvs.isNotEmpty) {
        final _startMarker = await getPDVCustomMarker(
          detalle.visitado == "SI"
              ? true
              : DateFormat('dd-MM-yyyy').format(detalle.fecha!) ==
                  detalle.fechaVisitaVen,
          detalle.segmentoPdv.toString().substring(0, 1).toUpperCase(),
          detalle.fd11.toString() != 'null' &&
              detalle.fd11.toString().isNotEmpty,
          detalle.qbrMbl.toString().toUpperCase().contains("SI") &&
              !detalle.qbrMbl.toString().toUpperCase().contains("SIN"),
          detalle.qbrTmy.toString().toUpperCase().contains("SI") &&
              !detalle.qbrTmy.toString().toUpperCase().contains("SIN"),
        );
        final newMarker = Marker(
          anchor: const Offset(0.1, 0.9),
          markerId: MarkerId(detalle.idPdv.toString()),
          position: LatLng(detalle.latitude!, detalle.longitude!),
          icon: _startMarker,
          onTap: () {
            showModalBottomSheet(
                context: context2,
                builder: (builder) {
                  return BottomMapModal(
                    detalle: detalle,
                  );
                });
          },
        );
        currentMarkers[detalle.idPdv.toString()] = newMarker;
      }
    }

    final routeMarkers = Map<String, Marker>.from(state.markers);
    final startMarker = routeMarkers['start'];
    final endMarker = routeMarkers['end'];

    if (startMarker != null) {
      currentMarkers['start'] = startMarker;
      currentMarkers['end'] = endMarker!;
    }

    final currentPolylines = Map<String, Polyline>.from(state.polylines);

    add(OnDisplayPolylinesEvent(currentPolylines, currentMarkers));

    //await Future.delayed(const Duration(milliseconds: 300));

    //_mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }

  Future drawMarkersCircuito({
    required List<Circuito> circuitos,
    required BuildContext context2,
    DateTime? fecha,
  }) async {
    DBService _dbService = DBService();

    MapBloc mapBloc;

    final usuario = await _dbService.getUsuario();

    mapBloc = BlocProvider.of<MapBloc>(context2);

    final _listaPdvs = await _dbService.leerListadoPdv(
      circuitos: circuitos,
      mapa: true,
      usuario: (usuario.first.perfil == 6 || usuario.first.perfil == 5)
          ? ""
          : usuario.first.usuario.toString(),
      fecha: fecha,
    );

    final currentMarkers = <String, Marker>{};

    for (final detalle in _listaPdvs) {
      final _startMarker = await getPDVCustomMarker(
        (detalle.visitado == "SI") ? true : false,
        detalle.segmentoPdv.toString().substring(0, 1).toUpperCase(),
        detalle.fd11.toString() != 'null' && detalle.fd11.toString().isNotEmpty,
        detalle.qbrMbl.toString().toUpperCase().contains("SI"),
        detalle.qbrTmy.toString().toUpperCase().contains("SI"),
      );

      final newMarker = Marker(
        anchor: const Offset(0.1, 0.9),
        markerId: MarkerId(detalle.idPdv.toString()),
        position: LatLng(
          detalle.latitude!,
          detalle.longitude!,
        ),
        icon: _startMarker,
        onTap: () {
          showModalBottomSheet(
              context: context2,
              isDismissible: false,
              backgroundColor: Colors.transparent,
              builder: (builder) {
                return BottomMapModal(
                  detalle: detalle,
                );
              }).then((value) {
            final circuitos = mapBloc.state.circuitosSeleccionados;
            mapBloc.drawMarkersCircuito(
              circuitos: circuitos,
              context2: context2,
            );
          });
        },
      );

      currentMarkers[detalle.idPdv.toString()] = newMarker;
    }

    /*REVISAR JOSUE MARQUEZ */
    //final routeMarkers = Map<String, Marker>.from(state.markers);

    final currentPolylines = <String, Polyline>{};
    add(
      OnDisplayPolylinesEvent(
        currentPolylines,
        currentMarkers,
      ),
    );
    add(
      OnUpdateCircuitosSeleccionadosEvent(
        circuitosSeleccionados: circuitos,
      ),
    );
  }

  /*Fin Dibujar Marcadores*/

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
