import 'package:bank_sha/services/user_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserEvent>((event, emit) async {
      if (event is UserGetByUsermameEvent) {
        try {
          emit(UserLoadingState());

          final users = await UserService().getUsersByUsername(event.username);

          users.fold((l) => emit(UserFailedState(l)),
              (r) => emit(UserSuccessState(r)));
        } catch (e) {
          emit(UserFailedState(e.toString()));
        }
      }

      if (event is UserGetRecentEvent) {
        try {
          emit(UserLoadingState());

          final users = await UserService().getRecentUsers();

          users.fold((l) => emit(UserFailedState(l)),
              (r) => emit(UserSuccessState(r)));
        } catch (e) {
          emit(UserFailedState(e.toString()));
        }
      }
    });
  }
  void getUser(UserBloc userBloc, String value) {
    if (value.isNotEmpty) {
      userBloc.add(UserGetByUsermameEvent(value));
    } else {
      userBloc.add(UserGetRecentEvent());
    }
  }
}
