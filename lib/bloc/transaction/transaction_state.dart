part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionFailedState extends TransactionState {
  final String error;

  const TransactionFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class TransactionSuccessState extends TransactionState {
  final List<TransactionModel> transactions;

  const TransactionSuccessState(this.transactions);

  @override
  List<Object> get props => [transactions];
}
