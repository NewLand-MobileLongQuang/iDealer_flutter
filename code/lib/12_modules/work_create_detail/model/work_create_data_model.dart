import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/models/attachment.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/mst_smkpi_plus_data.dart';

class WorkCreateDataModel {
  WorkCreateDataModel() {}

  Rx<String> createLongDateTime =
      AppConfig().apiLongDatetimeFormat.format(DateTime.now()).obs;
  Rx<String> workCode = "".obs;

  List<Attachment> attachImages = <Attachment>[].obs;

  Rx<MstSMKPIPlusData> work = MstSMKPIPlusData().obs;
  Rx<String> location = "".obs;
  Rx<String> decs = "".obs;

  Rx<DateTime> processLongDateTime = DateTime.now().obs;
  Rx<CodeName> level = CodeName("", "").obs;
  Rx<String> status = "".obs;
  Rx<CodeName> evaluate = CodeName("", "").obs;

  Rx<String> opportunityCode = "".obs;
  Rx<String> cusCode = "".obs;
  Rx<String> cusName = "".obs;
  Rx<String> cusPhone = "".obs;
  Rx<String> contactCode = "".obs;
  Rx<String> contactName = "".obs;
  Rx<String> contactPhone = "".obs;
}
