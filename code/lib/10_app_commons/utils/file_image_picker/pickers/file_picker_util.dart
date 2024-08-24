import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<File?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  static Future<String?> pickFileBase64() async {
    File? file = await pickSingleFile();
    if (file != null) {
      return base64Encode(file.readAsBytesSync());
    }
    return null;
  }
}
