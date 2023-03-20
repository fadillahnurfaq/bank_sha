import 'package:bank_sha/services/operator_card_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/operator_card/operator_card_model.dart';

part 'operator_card_event.dart';
part 'operator_card_state.dart';

class OperatorCardBloc extends Bloc<OperatorCardEvent, OperatorCardState> {
  OperatorCardBloc() : super(OperatorCardInitialState()) {
    on<OperatorCardEvent>((event, emit) async {
      if (event is OperatorCardGetEvent) {
        try {
          emit(OperatorCardLoadingState());

          final operatorCards = await OperatorCardService().getOperatorCards();
          operatorCards.fold((l) => emit(OperatorCardFailedState(l)),
              (r) => emit(OperatorCardSucessState(r)));
        } catch (e) {
          emit(OperatorCardFailedState(e.toString()));
        }
      }
    });
  }
}
