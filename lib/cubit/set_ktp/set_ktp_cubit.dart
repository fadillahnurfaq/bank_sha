import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/picker/select_image.dart';

class SetKtpCubit extends Cubit<XFile?> {
  SetKtpCubit() : super(null);

  void changeKtp() async {
    final image = await selectImage();
    if (image != null) {
      emit(image);
    }
  }
}
