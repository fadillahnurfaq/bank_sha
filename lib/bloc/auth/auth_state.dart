part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailedState extends AuthState {
  final String error;
  const AuthFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class AuthCheckEmailSuccessState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserModel user;
  const AuthSuccessState(this.user);

  @override
  List<Object> get props => [user];
}
