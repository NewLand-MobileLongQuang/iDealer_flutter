import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';
import 'package:idealer/11_apis/core/models/user_by_dealer_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';
import 'package:idealer/11_screens/home/ui/dialogs/choice_common_dialog.dart';

class RelatedOpportunityController extends BaseController<List<SPSalesProcessSearchData>>{
  List<SPSalesProcessSearchData> opportunities = [SPSalesProcessSearchData()];

  @override
  Future<List<SPSalesProcessSearchData>> load(int loadLimit) async{
    opportunities = await IDealerApiService.getSPSalesProcessSearch(
        opportunityCode.value,
        fromDateTime.value,
        toDateTime.value,
        cusName.value,
        phone.value,
        staffName.value,
        status.value,
        0, loadLimit);
    if (opportunities.isEmpty){
      opportunities = [SPSalesProcessSearchData()];
    }
   return opportunities;
  }

  setOpportunity(RelatedOpportunityController controller){
    controller.reload();
  }

  void setInit() async{
    userByDealers = await IDealerApiService.getUserByDealer();
    userByDealersString = userByDealers.map((e) => e.userName??"").toList();
  }

  List<UserByDealerData> userByDealers = [];
  List<String> userByDealersString = [];

  Rx<String> opportunityCode = "".obs;
  Rx<String> cusName = "".obs;
  Rx<String> phone = "".obs;
  Rx<String> fromDateTime = "".obs;
  Rx<String> toDateTime = "".obs;
  Rx<String> staffName = "".obs;
  Rx<String> status = "".obs;

  String userByDealerDefault = "${UserSessionController.instance().userInfo?.user?.userName}";


  DateTime fromDateInit = DateTime.now();
  DateTime toDateInit = DateTime.now();

  void setFromDateTime(BuildContext context) async{
    var newDate = await showDatePicker(
        context: context,
        initialDate: fromDateInit,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) return;
    fromDateTime.value = AppConfig.instance().dateFormat.format(newDate);
    fromDateInit = newDate;
  }

  void setToDateTime(BuildContext context) async{
    var newDate = await showDatePicker(
        context: context,
        initialDate: toDateInit,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (newDate == null) return;
    toDateTime.value = AppConfig.instance().dateFormat.format(newDate);
    toDateInit = newDate;
  }

  void setStaff() async{
    var result = await ChoiceCommonDialog.show("Nhân viên", userByDealersString);
    if (result == null) return;
    staffName.value = result.name;
  }

}