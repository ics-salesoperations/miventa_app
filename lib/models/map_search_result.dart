import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearchResult {
  final bool cancel;
  final bool manual;
  final LatLng? position;
  final String? name;
  final String? description;

  MapSearchResult(
      {required this.cancel,
      this.manual = false,
      this.position,
      this.name,
      this.description});

  @override
  String toString() {
    return 'cancel: $cancel, manual: $manual';
  }
}
