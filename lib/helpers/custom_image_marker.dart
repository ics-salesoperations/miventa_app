import 'dart:ui' as UI;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker() async {
  final resp = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'assets/custom-pin.png',
  );

  return resp;
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );

  //Resize Image
  final imageCodec = await UI.instantiateImageCodec(resp.data,
      targetHeight: 150, targetWidth: 150);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: UI.ImageByteFormat.png);

  if (data == null) {
    return await getAssetImageMarker();
  }

  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
