part of 'operator_card_bloc.dart';

abstract class OperatorCardState extends Equatable {
  const OperatorCardState();

  @override
  List<Object> get props => [];
}

class OperatorCardInitialState extends OperatorCardState {}

class OperatorCardLoadingState extends OperatorCardState {}

class OperatorCardFailedState extends OperatorCardState {
  final String error;

  const OperatorCardFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class OperatorCardSucessState extends OperatorCardState {
  final List<OperatorCardModel> operatorCards;

  const OperatorCardSucessState(this.operatorCards);

  @override
  List<Object> get props => [operatorCards];
}
