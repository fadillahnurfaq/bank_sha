import 'package:bank_sha/models/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_transfer_event.dart';

class SelectedTransferBloc extends Bloc<SelectedTransferEvent, UserModel?> {
  SelectedTransferBloc() : super(null) {
    on<SelectedTransferEvent>((event, emit) {
      if (event is ChangeSelectedTransferEvent) {
        emit(event.user);
      }
    });
  }
}
