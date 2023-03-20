part of 'tip_bloc.dart';

abstract class TipEvent extends Equatable {
  const TipEvent();

  @override
  List<Object> get props => [];
}

class TipGetEvent extends TipEvent {}
