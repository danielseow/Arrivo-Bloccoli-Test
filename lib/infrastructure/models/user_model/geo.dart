import 'package:arrivo_test/domain/entities/user/geo.dart';

class GeoModel extends Geo {
  const GeoModel({
    required String lat,
    required String lng,
  }) : super(lat: lat, lng: lng);

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}