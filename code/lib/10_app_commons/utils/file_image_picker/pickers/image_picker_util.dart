import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static Future<XFile?> pickImageFromGallery() async {
    ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );
  }

  static Future<XFile?> pickImageFromCamera() async {
    ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
    );
  }

  static Future<List<XFile>?> pickMultiImage() async {
    ImagePicker _picker = ImagePicker();
    return await _picker.pickMultiImage(
      maxWidth: 1000,
      maxHeight: 1000,
    );
  }
}
