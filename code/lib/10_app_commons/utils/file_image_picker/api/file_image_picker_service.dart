import 'package:dio/dio.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/requests/igoss_upload_file/igoss_upload_file_request.dart';
// import 'package:igoss/modules/ecore_modules/inventory2/commons_base/utils/file_image_picker/api/requests/igoss_upload_file/igoss_upload_file_request.dart';
// import 'package:igoss/modules/ecore_modules/inventory2/00_core/inventory_app_config.dart';

import 'models/attachment.dart';
import 'requests/igoss_upload_file_large/igoss_upload_file_large_request.dart';

class FileImagePickerService {
  static Future<Attachment?> uploadFile(
      String fileName, String fileBase64) async {
    var request = IGossUploadFileRequest(
      fileBase64: fileBase64,
      fileName: fileName,
    );
    var response = await request.invoke();
    print('response; $response');
    if (response.Url == null) {
      return null;
    }
    print("AttachmentsRESponse: ${response}\n");
    return Attachment(
      fileName: fileName,
      url: response.Url ?? '',
      fileSize: 300,
    );
  }

  // static Future<Attachment?> uploadFileLarge(
  //     MultipartFile file, String fileName) async {
  //   var request = IGossUploadFileLargeRequest(
  //     fileName: fileName,
  //     file: file,
  //   );
  //   var response = await request.invoke();
  //   if (response.data == null) {
  //     return null;
  //   }
  //   print("uploadFileLarge: ${response.data?.name} | ${response.data?.url}");
  //   return Attachment(
  //     fileName: response.data?.fileName ?? '',
  //     url:
  //         '${InventoryAppConfig.instance().uploadedFileBaseUrl}${response.data?.url ?? ''}',
  //     fileSize: response.data?.fileSize ?? 0,
  //   );
  // }
}
