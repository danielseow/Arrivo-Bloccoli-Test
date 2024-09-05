import 'package:arrivo_test/domain/entities/user/user.dart';
import 'package:arrivo_test/domain/repositories/users_repository.dart';
import 'package:arrivo_test/infrastructure/api/user_api.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UserAPI _userAPI;

  UsersRepositoryImpl(this._userAPI);
  @override
  Future<List<User>> getUsers() async {
    final userModels = await _userAPI.getUsers();
    return userModels;
  }
}
