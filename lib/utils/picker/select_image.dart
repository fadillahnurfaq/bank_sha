import 'package:image_picker/image_picker.dart';

Future<XFile?> selectImage() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );

  return selectedImage;
}
