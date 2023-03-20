import 'package:flutter_bloc/flutter_bloc.dart';

class PinErrorCubit extends Cubit<bool> {
  PinErrorCubit() : super(false);

  void changeError(bool error) {
    emit(error);
  }
}
