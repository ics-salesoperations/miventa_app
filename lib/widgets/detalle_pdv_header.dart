import 'package:flutter/material.dart';
import 'package:miventa_app/app_styles.dart';
import 'package:miventa_app/models/models.dart';

class DetallePDVHeader extends StatelessWidget {
  final Planning detalle;
  final String titulo;

  const DetallePDVHeader(
      {Key? key, required this.detalle, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
              fontFamily: 'Cronos-Pro',
            ),
          ),
          Text(
            detalle.idPdv!.toString() + ' - ' + detalle.nombrePdv!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'Cronos-Pro',
            ),
          ),
          Text(
            "Actualizado al " +
                detalle.fechaActualizacion!.replaceFirst('00:00:00', ''),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'Cronos-Pro',
            ),
          ),
          /*
          TextButton.icon(
            label: const Text(
              "Ir al Punto de Venta",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'Cronos-Pro',
              ),
            ),
            onPressed: () async {
              //searchBloc.add(onActivateManualMarkerEvent());
              final start = locationBloc.state.lastKnownLocation;
              if (start == null) return;

              final end = LatLng(detalle.latitude!, detalle.longitude!);
              if (end == null) return;

              //showLoadingMessage(context);

              final destination =
                  await searchBloc.getCoorsStartToEnd(start, end);

              await mapBloc.drawRoutePolyline(destination, detalle, context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabScreen(
                    selectedIndex: 2,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.location_on_rounded),
          ),*/
        ],
      ),
    );
  }
}
