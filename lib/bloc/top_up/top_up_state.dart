part of 'top_up_bloc.dart';

abstract class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object> get props => [];
}

class TopupInitialState extends TopUpState {}

class TopupLoadingState extends TopUpState {}

class TopUpFailedState extends TopUpState {
  final String error;

  const TopUpFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class TopupSuccessState extends TopUpState {
  final String redirectUrl;

  const TopupSuccessState(this.redirectUrl);

  @override
  List<Object> get props => [redirectUrl];
}
