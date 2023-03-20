part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserFailedState extends UserState {
  final String error;

  const UserFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class UserSuccessState extends UserState {
  final List<UserModel> users;

  const UserSuccessState(this.users);

  @override
  List<Object> get props => [users];
}
