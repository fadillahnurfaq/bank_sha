import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/operator_card/operator_card_model.dart';

class SelectedPackageCubit extends Cubit<DataPlanModel?> {
  SelectedPackageCubit() : super(null);

  void changeSelected(DataPlanModel data) {
    emit(data);
  }
}
