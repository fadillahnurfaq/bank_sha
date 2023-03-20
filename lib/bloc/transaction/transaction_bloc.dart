import 'package:bank_sha/services/transaction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transaction/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitialState()) {
    on<TransactionEvent>((event, emit) async {
      if (event is GetTransactionEvent) {
        try {
          emit(TransactionLoadingState());

          final dataTransaction = await TransactionService().getTransactions();

          dataTransaction.fold((l) => emit(TransactionFailedState(l)),
              (r) => emit(TransactionSuccessState(r)));
        } catch (e) {
          emit(TransactionFailedState(e.toString()));
        }
      }
    });
  }
}
