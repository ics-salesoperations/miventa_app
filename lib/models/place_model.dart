import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel with ClusterItem {
  int? id;
  int? type;
  String? name;
  final LatLng latLng;

  PlaceModel({
    required this.name,
    required this.latLng,
    required this.type,
    required this.id,
  });

  @override
  LatLng get location => latLng;
}
