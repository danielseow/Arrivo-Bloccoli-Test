import 'package:equatable/equatable.dart';

import 'address.dart';
import 'company.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  const User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      username,
      email,
      address,
      phone,
      website,
      company,
    ];
  }
}
