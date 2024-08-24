import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'api/file_image_picker_service.dart';
import 'api/models/attachment.dart';
import 'models/file_picked.dart';
import 'pickers/file_picker_util.dart';
import 'pickers/image_picker_util.dart';
import 'ui/file_image_picker_bottom_sheet.dart';

class FileImagePickerUtil {
  static Future<FilePicked?> pick(
    BuildContext context, {
    bool fromGallery = false,
    bool fromCamera = false,
    bool fromFile = false,
  }) async {
    if (!fromGallery && !fromCamera && !fromFile) return null;

    FileImagePickerBottomSheetResult? result;
    if (fromGallery && !fromCamera && !fromFile) {
      result = FileImagePickerBottomSheetResult.gallery;
    } else if (!fromGallery && fromCamera && !fromFile) {
      result = FileImagePickerBottomSheetResult.camera;
    } else if (!fromGallery && !fromCamera && fromFile) {
      result = FileImagePickerBottomSheetResult.file;
    } else {
      result = await FileImagePickerBottomSheet.show(context,
          fromGallery: fromGallery, fromCamera: fromCamera, fromFile: fromFile);
    }

    switch (result) {
      case FileImagePickerBottomSheetResult.gallery:
        {
          var xFile = await ImagePickerUtil.pickImageFromGallery();
          if (xFile != null) {
            return await FilePicked.fromXFile(xFile);
          }
          return null;
        }
      case FileImagePickerBottomSheetResult.camera:
        {
          var xFile = await ImagePickerUtil.pickImageFromCamera();
          if (xFile != null) {
            return await FilePicked.fromXFile(xFile);
          }
          return null;
        }
      case FileImagePickerBottomSheetResult.file:
        {
          var file = await FilePickerUtil.pickSingleFile();
          if (file != null) {
            return await FilePicked.fromFile(file);
          }
          return null;
        }
      default:
    }
  }

  static Future<String?> pickBase64(
    BuildContext context, {
    bool fromGallery = false,
    bool fromCamera = false,
    bool fromFile = false,
  }) async {
    if (!fromGallery && !fromCamera && !fromFile) return null;

    FileImagePickerBottomSheetResult? result;
    if (fromGallery && !fromCamera && !fromFile) {
      result = FileImagePickerBottomSheetResult.gallery;
    } else if (!fromGallery && fromCamera && !fromFile) {
      result = FileImagePickerBottomSheetResult.camera;
    } else if (!fromGallery && !fromCamera && fromFile) {
      result = FileImagePickerBottomSheetResult.file;
    } else {
      result = await FileImagePickerBottomSheet.show(context,
          fromGallery: fromGallery, fromCamera: fromCamera, fromFile: fromFile);
    }

    switch (result) {
      case FileImagePickerBottomSheetResult.gallery:
        {
          print("test");
          var xFile = await ImagePickerUtil.pickImageFromGallery();
          var xFileLength = await xFile?.length();
          print("test 2: xFile.length: $xFileLength}");
          if (xFile != null) {
            return _convertXFileToBase64(xFile);
          }
          return null;
        }
      case FileImagePickerBottomSheetResult.camera:
        {
          var xFile = await ImagePickerUtil.pickImageFromCamera();
          if (xFile != null) {
            return _convertXFileToBase64(xFile);
          }
          return null;
        }
      case FileImagePickerBottomSheetResult.file:
        {
          var file = await FilePickerUtil.pickSingleFile();
          if (file != null) {
            return _convertFileToBase64(file);
          }
          return null;
        }
      default:
    }
  }

  static Future<Attachment?> pickAndUpload(
    BuildContext context, {
    bool fromGallery = false,
    bool fromCamera = false,
    bool fromFile = false,
  }) async {
    if (!fromGallery && !fromCamera && !fromFile) return null;
    var filePicked = await pick(context,
        fromGallery: fromGallery, fromCamera: fromCamera, fromFile: fromFile);
    if (filePicked == null) {
      return null;
    }

    var fileBase64 = await filePicked.getBase64() ?? '';

    //upload file by api
    var result = await FileImagePickerService.uploadFile(
        filePicked.fileName, fileBase64);

    if (result != null) {
      return result;
    } else {
      debugPrint('upload File fail');
      return null;
    }
  }

  static Future<FilePicked?> pickFileLarge(
    BuildContext context, {
    bool fromGallery = false,
    bool fromCamera = false,
    bool fromFile = false,
  }) async {
    if (!fromGallery && !fromCamera && !fromFile) return null;
    return await pick(context,
        fromGallery: fromGallery, fromCamera: fromCamera, fromFile: fromFile);
  }

  // static Future<Attachment?> uploadFileLarge(
  //   BuildContext context, {
  //   required FilePicked filePicked,
  // }) async {
  //   Attachment? result;
  //   //upload file by api
  //   if (filePicked.file != null) {
  //     final multipartFile = await MultipartFile.fromFile(
  //       filePicked.file!.path,
  //       filename: filePicked.fileName,
  //     );
  //     result = await FileImagePickerService.uploadFileLarge(
  //         multipartFile, filePicked.fileName);
  //   } else {
  //     final multipartFile = await MultipartFile.fromFile(
  //       filePicked.xFile!.path,
  //       filename: filePicked.fileName,
  //     );
  //     result = await FileImagePickerService.uploadFileLarge(
  //         multipartFile, filePicked.fileName);
  //   }
  //
  //   if (result != null) {
  //     return result;
  //   } else {
  //     debugPrint('upload File fail');
  //     return null;
  //   }
  // }

  static Future<String?> _convertXFileToBase64(XFile xFile) async {
    return base64Encode(await xFile.readAsBytes());
  }

  static Future<String?> _convertFileToBase64(File file) async {
    return base64Encode(await file.readAsBytes());
  }
}
