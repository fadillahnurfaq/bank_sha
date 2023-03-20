part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEmailEvent extends AuthEvent {
  final String email;

  const AuthCheckEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class AuthRegisterEvent extends AuthEvent {
  final SignUpFormModel data;
  const AuthRegisterEvent(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLoginEvent extends AuthEvent {
  final SignInFormModel data;
  const AuthLoginEvent(this.data);

  @override
  List<Object> get props => [data];
}

class AuthGetCurrentUserEvent extends AuthEvent {}

class AuthUpdateUserEvent extends AuthEvent {
  final EditFormModel data;
  const AuthUpdateUserEvent(this.data);

  @override
  List<Object> get props => [data];
}

class AuthUpdatePinEvent extends AuthEvent {
  final String oldPin;
  final String newPin;
  const AuthUpdatePinEvent(
    this.oldPin,
    this.newPin,
  );

  @override
  List<Object> get props => [
        oldPin,
        newPin,
      ];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthUpdateBalanceEvent extends AuthEvent {
  final int amount;
  const AuthUpdateBalanceEvent(this.amount);

  @override
  List<Object> get props => [amount];
}
