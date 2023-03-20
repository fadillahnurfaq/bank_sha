import 'package:bank_sha/utils/picker/select_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SetProfileCubit extends Cubit<XFile?> {
  SetProfileCubit() : super(null);

  void changePhoto() async {
    final image = await selectImage();
    if (image != null) {
      emit(image);
    }
  }
}
