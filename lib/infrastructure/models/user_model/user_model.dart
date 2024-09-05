import 'dart:convert';

import 'package:arrivo_test/domain/entities/user/user.dart';

import 'address.dart';
import 'company.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
    required AddressModel address,
    required String phone,
    required String website,
    required CompanyModel company,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          address: address,
          phone: phone,
          website: website,
          company: company,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyModel.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': (address as AddressModel).toJson(),
      'phone': phone,
      'website': website,
      'company': (company as CompanyModel).toJson(),
    };
  }

  static List<UserModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }
}