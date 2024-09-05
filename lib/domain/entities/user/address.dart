import 'package:equatable/equatable.dart';

import 'geo.dart';

class Address extends Equatable {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}
