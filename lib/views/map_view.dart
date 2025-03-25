import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miventa_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const MapView({
    Key? key,
    required this.initialLocation,
    required this.polylines,
    required this.markers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 12);

    final size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height * 0.3,
        child: Listener(
          //cuando se mueve el dedo sobre la pantalla
          onPointerMove: (pointerEvent) =>
              mapBloc.add(OnStopFollowingUserEvent()),
          child: Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: initialCameraPosition,
                compassEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                polylines: polylines,
                markers: markers,
                onMapCreated: (controller) {
                  mapBloc.add(
                    OnMapInitializedEvent(
                      controller,
                      context,
                    ),
                  );
                },
                onCameraMove: (position) {
                  mapBloc.mapCenter = position.target;
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
              ),
            ],
          ),
        ));
  }
}
