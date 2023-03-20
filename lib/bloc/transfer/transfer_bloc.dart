import 'package:bank_sha/services/transaction_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transfer/transfer_form_model.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc() : super(TransferInitialState()) {
    on<TransferEvent>((event, emit) async {
      if (event is TransferPostEvent) {
        try {
          emit(TransferLoadingState());

          final transfer = await TransactionService().transfer(event.data);

          transfer.fold((l) => emit(TransferFailedState(l)),
              (r) => emit(TransferSuccessState()));
        } catch (e) {
          emit(TransferFailedState(e.toString()));
        }
      }
    });
  }
}
