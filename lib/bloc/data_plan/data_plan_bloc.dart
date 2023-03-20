import 'package:bank_sha/services/transaction_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/data_plan/data_plan_form_model.dart';

part 'data_plan_event.dart';
part 'data_plan_state.dart';

class DataPlanBloc extends Bloc<DataPlanEvent, DataPlanState> {
  DataPlanBloc() : super(DataPlanInitialState()) {
    on<DataPlanEvent>((event, emit) async {
      if (event is DataPlanPostEvent) {
        try {
          emit(DataPlanLoadingState());

          final data = await TransactionService().dataPlan(event.data);
          data.fold((l) => emit(DataPlanFailedState(l)),
              (r) => emit(DataPlanSuccessState()));
        } catch (e) {
          emit(DataPlanFailedState(e.toString()));
        }
      }
    });
  }
}
