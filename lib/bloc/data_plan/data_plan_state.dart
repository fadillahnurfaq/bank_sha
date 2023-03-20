part of 'data_plan_bloc.dart';

abstract class DataPlanState extends Equatable {
  const DataPlanState();

  @override
  List<Object> get props => [];
}

class DataPlanInitialState extends DataPlanState {}

class DataPlanLoadingState extends DataPlanState {}

class DataPlanFailedState extends DataPlanState {
  final String error;

  const DataPlanFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class DataPlanSuccessState extends DataPlanState {}
