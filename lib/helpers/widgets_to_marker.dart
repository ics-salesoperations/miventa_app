import 'dart:ui' as UI;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miventa_app/markers/markers.dart';

Future<BitmapDescriptor> getPDVCustomMarker(
  bool visitado,
  String segmento,
  final bool fd11,
  final bool quiebreMBL,
  final bool quiebreTMY,
) async {
  final recorder = UI.PictureRecorder();
  final canvas = UI.Canvas(recorder);
  const size = UI.Size(350, 150);

  final startMarker = PDVMarkerPainter(
    visitado: visitado,
    segmento: segmento,
    fd11: fd11,
    quiebreMBL: quiebreMBL,
    quiebreTMY: quiebreTMY,
  );

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: UI.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getTrackingMarker(int order) async {
  final recorder = UI.PictureRecorder();
  final canvas = UI.Canvas(recorder);
  const size = UI.Size(350, 150);

  final startMarker = TrackingMarker(order);

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: UI.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getStartCustomMarker(
    int minutes, String destination) async {
  final recorder = UI.PictureRecorder();
  final canvas = UI.Canvas(recorder);
  const size = UI.Size(500, 150);

  final startMarker = StartMarkerPainter(
    minutes: minutes,
    destination: destination,
  );

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: UI.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getEndCustomMarker(int kms, String destination) async {
  final recorder = UI.PictureRecorder();
  final canvas = UI.Canvas(recorder);
  const size = UI.Size(500, 150);

  final startMarker = EndMarkerPainter(
    kilometers: kms,
    destination: destination,
  );

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: UI.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
