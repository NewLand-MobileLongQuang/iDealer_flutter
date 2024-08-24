import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class FilePicked {
  String fileType;
  String fileName;
  XFile? xFile;
  File? file;
  int fileLength;

  FilePicked({
    required this.fileType,
    required this.fileName,
    this.xFile,
    this.file,
    required this.fileLength,
  });

  static Future<FilePicked> fromXFile(XFile xFile) async {
    var length = await xFile.length();
    var name = xFile.name;
    var path = xFile.path;
    return FilePicked(
      fileType: p.extension(path).replaceAll(".", "").toLowerCase(),
      fileName: name,
      fileLength: length,
      xFile: xFile,
    );
  }

  Future<String?> getBase64() async {
    if (xFile != null) {
      return await _convertXFileToBase64(xFile!);
    }
    if (file != null) {
      return await _convertFileToBase64(file!);
    }
    return null;
  }

  static Future<FilePicked> fromFile(File file) async {
    var length = await file.length();
    // var name = file.path.split('?').last.split('/').last;
    var path = file.path;

    return FilePicked(
      fileType: p.extension(path).toLowerCase(),
      fileName: p.basename(path),
      fileLength: length,
      file: file,
    );
  }

  static Future<String> _convertXFileToBase64(XFile xFile) async {
    return base64Encode(await xFile.readAsBytes());
  }

  static Future<String> _convertFileToBase64(File file) async {
    return base64Encode(await file.readAsBytes());
  }
}
