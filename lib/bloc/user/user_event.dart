part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGetByUsermameEvent extends UserEvent {
  final String username;

  const UserGetByUsermameEvent(this.username);

  @override
  List<Object> get props => [username];
}

class UserGetRecentEvent extends UserEvent {}
