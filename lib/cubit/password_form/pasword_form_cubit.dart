import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordFormCubit extends Cubit<bool> {
  PasswordFormCubit() : super(true);

  void changeVisible() {
    emit(!state);
  }
}
