import 'package:bank_sha/services/transaction_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/top_up/top_up_form_model.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  TopUpBloc() : super(TopupInitialState()) {
    on<TopUpEvent>((event, emit) async {
      if (event is TopupPostEvent) {
        try {
          emit(TopupLoadingState());

          final redirectUrl = await TransactionService().topUp(event.data);

          redirectUrl.fold((l) => emit(TopUpFailedState(l)),
              (r) => emit(TopupSuccessState(r)));
        } catch (e) {
          emit(TopUpFailedState(e.toString()));
        }
      }
    });
  }
}
