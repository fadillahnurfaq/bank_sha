part of 'transfer_bloc.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class TransferPostEvent extends TransferEvent {
  final TransferFormModel data;

  const TransferPostEvent(this.data);

  @override
  List<Object> get props => [data];
}
