import 'package:bank_sha/services/tip_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/tips/tip_model.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  TipBloc() : super(TipInitialState()) {
    on<TipEvent>((event, emit) async {
      if (event is TipGetEvent) {
        try {
          emit(TipLoadingState());

          final tips = await TipService().getTips();

          tips.fold(
              (l) => emit(TipFailedState(l)), (r) => emit(TipSucessState(r)));
        } catch (e) {
          emit(TipFailedState(e.toString()));
        }
      }
    });
  }
}
