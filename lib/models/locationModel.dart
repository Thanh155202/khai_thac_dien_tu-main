class LocationModel {
  final double lat;
  final double lng;

  LocationModel({
    required String lat,
    required String lng,
  }) : lat = double.parse(lat),
        lng = double.parse(lng);
}
