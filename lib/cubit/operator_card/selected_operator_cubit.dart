import 'package:bank_sha/models/operator_card/operator_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedOperatorCubit extends Cubit<OperatorCardModel?> {
  SelectedOperatorCubit() : super(null);

  void changeSelected(OperatorCardModel data) {
    emit(data);
  }
}
