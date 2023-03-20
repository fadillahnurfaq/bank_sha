part of 'tip_bloc.dart';

abstract class TipState extends Equatable {
  const TipState();

  @override
  List<Object> get props => [];
}

class TipInitialState extends TipState {}

class TipLoadingState extends TipState {}

class TipFailedState extends TipState {
  final String error;

  const TipFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class TipSucessState extends TipState {
  final List<TipModel> tips;

  const TipSucessState(this.tips);

  @override
  List<Object> get props => [tips];
}
