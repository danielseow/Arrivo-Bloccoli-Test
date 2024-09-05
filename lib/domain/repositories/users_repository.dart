
import 'package:arrivo_test/domain/entities/user/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
}

/// https://stackoverflow.com/questions/3499119/which-layer-should-repositories-go-in
