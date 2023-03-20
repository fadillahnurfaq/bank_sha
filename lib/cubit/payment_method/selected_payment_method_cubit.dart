import 'package:bank_sha/models/transaction/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedPaymentMethodCubit extends Cubit<PaymentMethodModel?> {
  SelectedPaymentMethodCubit() : super(null);

  void changeSelectedPayment(PaymentMethodModel data) {
    emit(data);
  }
}
