class CoordinateModel {
  final double lon;
  final double lat;

  CoordinateModel({
    required this.lat,
    required this.lon,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) {
    return CoordinateModel(
      lat: json['lon'].toDouble(),
      lon: json['lat'].toDouble(),
    );
  }
}
