import 'package:arrivo_test/application/usecases/get_users.dart';
import 'package:arrivo_test/domain/entities/user/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersUseCases usersUseCases;
  UserBloc({required this.usersUseCases}) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UsersLoading());
    try {
      final users = await usersUseCases.getUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
