part of 'transfer_bloc.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitialState extends TransferState {}

class TransferLoadingState extends TransferState {}

class TransferFailedState extends TransferState {
  final String error;

  const TransferFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class TransferSuccessState extends TransferState {}
