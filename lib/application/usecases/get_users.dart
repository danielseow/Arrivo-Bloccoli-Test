import 'package:arrivo_test/domain/entities/user/user.dart';
import 'package:arrivo_test/domain/repositories/users_repository.dart';

class UsersUseCases {
  final UsersRepository repository;
  UsersUseCases(this.repository);
  Future<List<User>> getUsers() async {
    return await repository.getUsers();
  }
}
