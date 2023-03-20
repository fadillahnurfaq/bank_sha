import 'package:bank_sha/models/auth/edit_form_model.dart';
import 'package:bank_sha/models/auth/sign_in_form_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/auth/sign_up_form_model.dart';
import '../../models/user/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckEmailEvent) {
        emit(AuthLoadingState());

        final res = await AuthService().checkEmail(event.email);

        res.fold((l) => emit(AuthFailedState(l)), (r) {
          if (r == false) {
            emit(AuthCheckEmailSuccessState());
          } else {
            emit(const AuthFailedState("Email Sudah Terpakai"));
          }
        });
      }

      if (event is AuthRegisterEvent) {
        emit(AuthLoadingState());

        final user = await AuthService().register(event.data);

        user.fold(
            (l) => emit(AuthFailedState(l)), (r) => emit(AuthSuccessState(r)));
      }

      if (event is AuthGetCurrentUserEvent) {
        try {
          emit(AuthLoadingState());

          final SignInFormModel data =
              await AuthService().getCredentialFromLocal();

          final user = await AuthService().login(data);
          user.fold((l) => emit(AuthFailedState(l)),
              (r) => emit(AuthSuccessState(r)));
        } catch (e) {
          emit(AuthFailedState(e.toString()));
        }
      }

      if (event is AuthLoginEvent) {
        try {
          emit(AuthLoadingState());

          final user = await AuthService().login(event.data);

          user.fold((l) => emit(AuthFailedState(l)),
              (r) => emit(AuthSuccessState(r)));
        } catch (e) {
          emit(AuthFailedState(e.toString()));
        }
      }

      if (event is AuthUpdateUserEvent) {
        try {
          final updatedUser = UserModel(
              username: event.data.username,
              name: event.data.name,
              email: event.data.email,
              password: event.data.password);
          emit(AuthLoadingState());

          final update = await UserService().updateUser(event.data);

          update.fold((l) => emit(AuthFailedState(l)),
              (r) => emit(AuthSuccessState(updatedUser)));
        } catch (e) {
          emit(AuthFailedState(e.toString()));
        }
      }

      if (event is AuthUpdateBalanceEvent) {
        if (state is AuthSuccessState) {
          final currentUser = (state as AuthSuccessState).user;

          final updateUser = currentUser.copywith(
            balance: currentUser.balance! + event.amount,
          );

          emit(AuthSuccessState(updateUser));
        }
      }

      if (event is AuthUpdatePinEvent) {
        try {
          if (state is AuthSuccessState) {
            final updateUser = (state as AuthSuccessState).user.copywith(
                  pin: event.newPin,
                );

            emit(AuthLoadingState());

            final updatePin =
                await UserService().updatePin(event.oldPin, event.newPin);

            updatePin.fold((l) => emit(AuthFailedState(l)),
                (r) => emit(AuthSuccessState(updateUser)));
          }
        } catch (e) {
          emit(
            AuthFailedState(
              e.toString(),
            ),
          );
        }
      }

      if (event is AuthLogoutEvent) {
        try {
          emit(AuthLoadingState());

          final logout = await AuthService().logout();
          logout.fold(
              (l) => emit(AuthFailedState(l)), (r) => emit(AuthInitialState()));
          emit(AuthInitialState());
        } catch (e) {
          emit(AuthFailedState(e.toString()));
        }
      }
    });
  }
}
