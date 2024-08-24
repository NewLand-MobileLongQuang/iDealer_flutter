import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/main_get/main_get.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/file_image_picker_service.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/api/models/attachment.dart';
import 'package:idealer/10_app_commons/utils/file_image_picker/file_image_picker_util.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/mst_smkpi_plus_data.dart';
import 'package:idealer/11_apis/core/models/save_work.dart';
import 'package:idealer/11_apis/core/models/work_detail_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/home/ui/dialogs/choice_common_dialog.dart';
import 'package:idealer/12_modules/work_create_detail/model/work_create_data_model.dart';
import 'package:idealer/12_modules/work_create_detail/service/work_create_service.dart';
import 'package:intl/intl.dart';

enum WorkCreateControllerMode { create, update, detail }

class WorkCreateController extends BaseController<bool> {
  late WorkCreateService service;
  late WorkCreateDataModel workCreateDataModel;
  WorkCreateControllerMode? mode;
  String schCode = "";
  late WorkDetailData workDetail = WorkDetailData();
  VoidCallback onState = () {};

  @override
  Future<bool> load(int loadLimit) async {
    service = await WorkCreateService.instance();
    workCreateDataModel = await service.getWorkCreateDataModel();

    workLst = await IDealerApiService.getMstSMKPIPlus();
    worksString = workLst.map((element) => element.kpiPlusName ?? "").toList();

    evaluateLst.add(CodeName("GOOD", "Hài lòng"));
    evaluateLst.add(CodeName("LOW", "Bình thường"));
    evaluateLst.add(CodeName("NOTGOOD", "Không hài lòng"));

    levelLst.add(CodeName("HIGH", "Cao"));
    levelLst.add(CodeName("LOW", "Thấp"));
    levelLst.add(CodeName("MEDIUM", "Trung bình"));

    if (mode == WorkCreateControllerMode.create) {
      workCreateDataModel.workCode.value =
          await IDealerApiService.getWorkCode();
    }
    if (mode == WorkCreateControllerMode.update ||
        mode == WorkCreateControllerMode.detail) {
      var result = await IDealerApiService.getWorkDetail(schCode);
      if (result.isNotEmpty) {
        workDetail = result[0];
        initData();
      }
    }
    return true;
  }

  void initData() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    workCreateDataModel.createLongDateTime.value = workDetail.createDTime ?? "";
    workCreateDataModel.workCode.value = workDetail.schCode ?? "";
    workCreateDataModel.work.value.kpiPlusName = workDetail.kpiPlusName ?? "";
    workCreateDataModel.work.value.kpiPlusCode = workDetail.kpiPlusCode ?? "";
    workCreateDataModel.decs.value = workDetail.remark ?? "";
    workCreateDataModel.location.value = workDetail.schLocation ?? "";
    workCreateDataModel.processLongDateTime.value =
        dateFormat.parse(workDetail.effDTimeStart ?? "");
    workCreateDataModel.status.value = workDetail.usStatus ?? "";

    if (workDetail.rankingType == "" || workDetail.rankingType == null) {
      workCreateDataModel.evaluate.value = CodeName("", "");
    } else {
      workCreateDataModel.evaluate.value = evaluateLst
          .where((element) =>
              element.code.toUpperCase().trim() ==
              (workDetail.rankingType ?? "").toUpperCase().trim())
          .first;
    }
    if (workDetail.levelType == "" || workDetail.levelType == null) {
      workCreateDataModel.level.value = CodeName("", "");
    } else {
      workCreateDataModel.level.value = levelLst
          .where((element) =>
              element.code.toUpperCase().trim() ==
              (workDetail.levelType ?? "").toUpperCase().trim())
          .first;
    }

    workCreateDataModel.attachImages.clear();
    if (workDetail.filePath != null) {
      if (workDetail.filePath != "") {
        workCreateDataModel.attachImages.add(Attachment(
            url: workDetail.filePath ?? "",
            fileName: workDetail.fileName ?? "",
            fileSize: 20));
        update(workCreateDataModel.attachImages, true);
      }
    }
    workCreateDataModel.opportunityCode.value = workDetail.salesId ?? "";
    workCreateDataModel.cusCode.value = workDetail.customerCode ?? "";
    workCreateDataModel.cusName.value = workDetail.fullName ?? "";
    workCreateDataModel.cusPhone.value = workDetail.phoneNo ?? "";

    workCreateDataModel.contactName.value =
        workDetail.customerContactName ?? "";
    workCreateDataModel.contactCode.value =
        workDetail.customerContactCode ?? "";
    workCreateDataModel.contactPhone.value =
        workDetail.customerContactPhoneNo ?? "";

    onState.call();
  }

  List<String> worksString = [];
  List<MstSMKPIPlusData> workLst = [];
  List<CodeName> evaluateLst = [];
  List<CodeName> levelLst = [];

  // chọn tên công việc
  void setWorkName() async {
    var result = await ChoiceCommonDialog.show("Tên công việc", worksString);
    if (result == null) return;
    // workName.value = result.name;
    workCreateDataModel.work.value = workLst[result.position];
  }

  void setPriorityLevel() async {
    List<String> levelsString = [];
    for (CodeName mLevel in levelLst) {
      levelsString.add(mLevel.name);
    }
    var result = await ChoiceCommonDialog.show("Mức độ ưu tiên", levelsString);
    if (result == null) return;
    // levelName.value = result.name;
    workCreateDataModel.level.value = levelLst[result.position];
  }

  void setStatus() async {
    List<String> statusString = ["P", "F", "C"];
    var result = await ChoiceCommonDialog.show("Trạng thái", statusString);
    if (result == null) return;
    // statusName.value = result.name;
    workCreateDataModel.status.value = statusString[result.position];
  }

  void setEvaluate() async {
    List<String> evaluatesString = [];
    for (CodeName mEvaluate in evaluateLst) {
      evaluatesString.add(mEvaluate.name);
    }
    var result = await ChoiceCommonDialog.show("Đánh giá", evaluatesString);
    if (result == null) return;
    // evaluateName.value = result.name;
    workCreateDataModel.evaluate.value = evaluateLst[result.position];
  }

  void setProcessDateTime(BuildContext context) async {
    var newDate = await showDatePicker(
        context: context,
        initialDate: workCreateDataModel.processLongDateTime.value,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) return;

    var newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    newTime ??= TimeOfDay.now();

    DateTime newDateTime = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      newTime.hour,
      newTime.minute,
    );

    workCreateDataModel.processLongDateTime.value = newDateTime;
  }

  void addImage(BuildContext context) async {
    var filePicked = await FileImagePickerUtil.pick(context,
        fromFile: false, fromCamera: true, fromGallery: true);
    if (filePicked != null) {
      print(filePicked.fileName);
      print(filePicked.fileType);
      print(await filePicked.getBase64());
      String? base64 = await filePicked.getBase64();
      var result = await FileImagePickerService.uploadFile(
          filePicked.fileName, base64 ?? "");
      if (result != null) {
        print("object ${result.url}");
        workCreateDataModel.attachImages.clear();
        workCreateDataModel.attachImages.add(result);
        update(workCreateDataModel.attachImages, true);
      }
    }
  }

  void removeImage(int index) {
    workCreateDataModel.attachImages.removeAt(index);
    update(workCreateDataModel.attachImages, true);
  }

  void saveWork() async {
    SaveWork saveWork = SaveWork();

    if (workCreateDataModel.work.value.kpiPlusName == "" ||
        workCreateDataModel.work.value.kpiPlusName == null) {
      MainGet.errorDialog(error: "Không được để trống tên công việc");
      return;
    }

    if (AppConfig()
            .apiLongDatetimeFormat
            .format(workCreateDataModel.processLongDateTime.value) ==
        "") {
      MainGet.errorDialog(error: "Không được để trống thời gian thực hiện");
      return;
    }

    if (workCreateDataModel.status.value == "") {
      MainGet.errorDialog(error: "Không được để trống trạng thái");
      return;
    }

    if (workCreateDataModel.work.value.kpiPlusCode != null) {
      saveWork.kPIPlusCode =
          workCreateDataModel.work.value.kpiPlusCode; // mã công việc
      saveWork.kPIPlusName =
          workCreateDataModel.work.value.kpiPlusName; // tên công việc
    }

    if (workCreateDataModel.attachImages.isNotEmpty) {
      saveWork.fileName =
          workCreateDataModel.attachImages[0].fileName; // tên ảnh
      saveWork.filePath = workCreateDataModel.attachImages[0].url; // link ảnh
    }

    saveWork.rankingType = workCreateDataModel.evaluate.value.code; // đánh giá
    saveWork.levelType = workCreateDataModel.level.value.code; // mức độ ưu tiê

    saveWork.salesID = workCreateDataModel.opportunityCode.value;
    saveWork.schLocation = workCreateDataModel.location.value;
    saveWork.effDTimeStart = AppConfig.instance()
        .apiLongDatetimeFormat
        .format(workCreateDataModel.processLongDateTime.value);

    saveWork.uSStatus = workCreateDataModel.status.value;
    saveWork.remark = workCreateDataModel.decs.value;
    saveWork.customerCode = workCreateDataModel.cusCode.value;
    saveWork.fullName = workCreateDataModel.cusName.value;
    saveWork.phoneNo = workCreateDataModel.cusPhone.value;

    saveWork.customerContactCode = workCreateDataModel.contactCode.value;
    saveWork.customerContactName = workCreateDataModel.contactName.value;
    saveWork.customerContactPhoneNo = workCreateDataModel.contactPhone.value;

    if (mode == WorkCreateControllerMode.create) {
      saveWork.schCode = workCreateDataModel.workCode.value;
      saveWork.createDTime =
          workCreateDataModel.createLongDateTime.value; // thời gian tạo
      saveWork.userCodeOwner = UserSessionController.instance()
          .userInfo
          ?.user
          ?.userCode; // nhân viên sở hữu
      saveWork.createBy = UserSessionController.instance()
          .userInfo
          ?.user
          ?.userCode; // người tạo
      saveWork.effDTimeEnd = "";
      saveWork.lUDTime = "";
      saveWork.lUBy = "";
      try {
        print("SaveWorkCreateJson: ${jsonEncode(saveWork.toString())}");
        var future = IDealerApiService.saveWorkCreate(saveWork);
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          // MainGet.showToast("Lưu công việc thành công");
          Get.back(result: true);
        } else {
          MainGet.errorDialog(error: "Lưu thất bại");
        }
      } catch (error) {
        MainGet.errorDialog(error: "Lưu thất bại");
      }
    }

    if (mode == WorkCreateControllerMode.update) {
      saveWork.schCode = workCreateDataModel.workCode.value;
      saveWork.createDTime =
          workCreateDataModel.createLongDateTime.value; // thời gian tạo
      saveWork.userCodeOwner = workDetail.userCodeOwner; // nhân viên sở hữu
      saveWork.createBy = workDetail.createBy; // người tạo
      saveWork.lUDTime = workDetail.ludTime;
      saveWork.lUBy = workDetail.luBy;
      saveWork.effDTimeEnd = workDetail.effDTimeEnd;
      try {
        print("SaveWorkUpdateJson: ${jsonEncode(saveWork.toString())}");
        var future = IDealerApiService.saveWorkUpdate(saveWork);
        var result = await MainGet.showHudProgress(future);
        if (result == true) {
          Get.back(result: true);
        } else {
          MainGet.errorDialog(error: "Lưu thất bại");
        }
      } catch (error) {
        MainGet.errorDialog(error: "Lưu thất bại");
      }
    }
  }
}
