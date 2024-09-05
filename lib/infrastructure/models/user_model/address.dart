import 'package:arrivo_test/domain/entities/user/address.dart';

import 'geo.dart';

class AddressModel extends Address {
  const AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    required GeoModel geo,
  }) : super(
          street: street,
          suite: suite,
          city: city,
          zipcode: zipcode,
          geo: geo,
        );
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'],
        suite: json['suite'],
        city: json['city'],
        zipcode: json['zipcode'],
        geo: GeoModel.fromJson(json['geo']),
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': (geo as GeoModel).toJson(),
      };
}
