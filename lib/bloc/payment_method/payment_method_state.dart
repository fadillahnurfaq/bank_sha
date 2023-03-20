part of 'payment_method_bloc.dart';

abstract class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object> get props => [];
}

class PaymentMethodInitialState extends PaymentMethodState {}

class PaymentMethodLoadingState extends PaymentMethodState {}

class PaymentMethodFailedState extends PaymentMethodState {
  final String error;

  const PaymentMethodFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class PaymentMethodSuccess extends PaymentMethodState {
  final List<PaymentMethodModel> paymentMethods;

  const PaymentMethodSuccess(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}
