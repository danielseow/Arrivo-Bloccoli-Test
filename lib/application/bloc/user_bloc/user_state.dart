part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UserState {}

final class UsersLoading extends UserState {}

final class UsersLoaded extends UserState {
  final List<User> users;
  const UsersLoaded(this.users);
}

final class UserError extends UserState {
  final String message;
  const UserError(this.message);
}
