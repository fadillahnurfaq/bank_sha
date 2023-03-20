import 'package:bank_sha/services/payment_method_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transaction/transaction_model.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitialState()) {
    on<PaymentMethodEvent>((event, emit) async {
      if (event is PaymentMethodGetEvent) {
        try {
          emit(PaymentMethodLoadingState());

          final paymentMethods =
              await PaymentMethodService().getPaymentMethods();

          paymentMethods.fold((l) => emit(PaymentMethodFailedState(l)),
              (r) => emit(PaymentMethodSuccess(r)));
        } catch (e) {
          emit(PaymentMethodFailedState(e.toString()));
        }
      }
    });
  }
}
