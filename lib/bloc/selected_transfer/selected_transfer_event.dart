part of 'selected_transfer_bloc.dart';

abstract class SelectedTransferEvent extends Equatable {
  const SelectedTransferEvent();

  @override
  List<Object> get props => [];
}

class ChangeSelectedTransferEvent extends SelectedTransferEvent {
  final UserModel user;

  const ChangeSelectedTransferEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
