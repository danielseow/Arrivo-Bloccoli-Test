import 'package:arrivo_test/domain/entities/user/user.dart';
import 'package:arrivo_test/infrastructure/models/user_model/user_model.dart';

import 'base_api.dart';

class UserAPI {
  final BaseAPI _baseAPI;

  UserAPI(this._baseAPI);

  Future<List<User>> getUsers() async {
    final response = await _baseAPI.get('/users');
    return (response as List).map((json) => UserModel.fromJson(json)).toList();
  }
}