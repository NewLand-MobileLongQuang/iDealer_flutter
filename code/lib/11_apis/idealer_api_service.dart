import 'package:idealer/11_apis/core/models/car_color_data.dart';
import 'package:idealer/11_apis/core/models/car_model_data.dart';
import 'package:idealer/11_apis/core/models/car_plan_data.dart';
import 'package:idealer/11_apis/core/models/car_spec_data.dart';
import 'package:idealer/11_apis/core/models/customer_group_type_data.dart';
import 'package:idealer/11_apis/core/models/customer_source_data.dart';
import 'package:idealer/11_apis/core/models/customer_type_data.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';
import 'package:idealer/11_apis/core/models/marketing_strategy_data.dart';
import 'package:idealer/11_apis/core/models/mst_card_type_data.dart';
import 'package:idealer/11_apis/core/models/mst_district_data.dart';
import 'package:idealer/11_apis/core/models/mst_province_data.dart';
import 'package:idealer/11_apis/core/models/mst_smkpi_plus_data.dart';
import 'package:idealer/11_apis/core/models/pivot_retain_data.dart';
import 'package:idealer/11_apis/core/models/reason_cancel_data.dart';
import 'package:idealer/11_apis/core/models/sales_process_search_data.dart';
import 'package:idealer/11_apis/core/models/save_dealer_customer_create_data.dart';
import 'package:idealer/11_apis/core/models/save_sp_sales_process_data.dart';
import 'package:idealer/11_apis/core/models/save_work.dart';
import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';
import 'package:idealer/11_apis/core/models/user_by_dealer_data.dart';
import 'package:idealer/11_apis/core/models/work_detail_data.dart';
import 'package:idealer/11_apis/core/models/zalo_data.dart';
import 'package:idealer/11_apis/core/requests/check_phone_no/check_phone_no_request.dart';
import 'package:idealer/11_apis/core/requests/check_phone_no/response/check_phone_no_response.dart';
import 'package:idealer/11_apis/core/requests/delete_customer/delete_customer_request.dart';
import 'package:idealer/11_apis/core/requests/delete_work/delete_work_request.dart';
import 'package:idealer/11_apis/core/requests/get_car_color/car_color_request.dart';
import 'package:idealer/11_apis/core/requests/get_car_model/car_model_request.dart';
import 'package:idealer/11_apis/core/requests/get_car_spec/car_spec_request.dart';
import 'package:idealer/11_apis/core/requests/get_customer_group_type/get_customer_group_type_request.dart';
import 'package:idealer/11_apis/core/requests/get_customer_no/get_customer_no_request.dart';
import 'package:idealer/11_apis/core/requests/get_customer_no/response/get_customer_no_response.dart';
import 'package:idealer/11_apis/core/requests/get_customer_source/customer_source_request.dart';
import 'package:idealer/11_apis/core/requests/get_customer_type/get_customer_type_request.dart';
import 'package:idealer/11_apis/core/requests/get_dealer_customer_by_code/get_dealer_customer_by_code_request.dart';
import 'package:idealer/11_apis/core/requests/get_dealer_customer_contact_search/dealer_customer_contact_search_request.dart';
import 'package:idealer/11_apis/core/requests/get_dealer_customer_search/dealer_customer_search_request.dart';
import 'package:idealer/11_apis/core/requests/get_marketing_strategy/marketing_strategy_request.dart';
import 'package:idealer/11_apis/core/requests/get_mst_card_type/mst_card_type_request.dart';
import 'package:idealer/11_apis/core/requests/get_mst_district/mst_district_request.dart';
import 'package:idealer/11_apis/core/requests/get_mst_province/mst_province_request.dart';
import 'package:idealer/11_apis/core/requests/get_mst_smkpi_plus/mst_smkpi_plus_request.dart';
import 'package:idealer/11_apis/core/requests/get_reason_cancel/reason_cancel_request.dart';
import 'package:idealer/11_apis/core/requests/get_report_pivot_retain/report_pivot_retain_request.dart';
import 'package:idealer/11_apis/core/requests/get_sale_id/sale_id_request.dart';
import 'package:idealer/11_apis/core/requests/get_sales_process_search/sales_process_search_request.dart';
import 'package:idealer/11_apis/core/requests/get_sp_sales_process/sp_sales_process_request.dart';
import 'package:idealer/11_apis/core/requests/get_wk_user_schedule/response/wk_user_schedule_response.dart';
import 'package:idealer/11_apis/core/requests/get_wk_user_schedule/wk_user_schedule_request.dart';
import 'package:idealer/11_apis/core/requests/get_work_detail/work_detail_request.dart';
import 'package:idealer/11_apis/core/requests/get_zalo/zalo_request.dart';
import 'package:idealer/11_apis/core/requests/save_dealer_customer/save_dealer_customer_create_request.dart';
import 'package:idealer/11_apis/core/requests/save_dealer_customer/save_dealer_customer_update_request.dart';
import 'package:idealer/11_apis/core/requests/save_opportunity/save_opportunity_create_request.dart';
import 'package:idealer/11_apis/core/requests/save_opportunity/save_opportunity_update_request.dart';
import 'package:idealer/11_apis/core/requests/save_work/save_work_create_request.dart';
import 'package:idealer/11_apis/core/requests/save_work/save_work_update_request.dart';
import 'package:idealer/11_apis/core/requests/update_phone_no/update_phone_no_request.dart';

import 'core/models/work_schedule_in_month_data.dart';
import 'core/requests/cancel_opportunity/cancel_opportunity_request.dart';
import 'core/requests/get_report_car_plan/report_car_plan_request.dart';
import 'core/requests/get_sp_sales_process_search/sp_sales_process_search_request.dart';
import 'core/requests/get_user_by_dealer/user_by_dealer_request.dart';
import 'core/requests/get_work_code/work_code_request.dart';
import 'core/requests/get_work_schedule_in_month/work_schedule_in_month_request.dart';

class IDealerApiService {
  // lấy ds tổng hợp xe đại lý
  static Future<List<CarPlanData>> getReportCarPlan() async {
    var request = ReportCarPlanRequest();
    var response = await request.invoke();
    if (response == []) {
      return [];
    }
    return response;
  }

  // lấy ds tồn kho
  static Future<List<PivotRetainData>> getReportPivotRetain() async {
    var request = ReportPivotRetainRequest();
    var response = await request.invoke();
    return response;
  }

  // lấy ds công việc trong ngày
  static Future<WkUserScheduleResponse> getWkUserSchedule(
      String fromDate,
      String toDate,
      String usStatus,
      String leveltype,
      String kpiplusname,
      int pageIndex,
      int pageCount) async {
    var request = WkUserScheduleRequest(fromDate, toDate, usStatus, leveltype,
        kpiplusname, pageIndex, pageCount);
    var response = await request.invoke();
    return response;
  }

  // lấy ds công việc tháng
  static Future<List<WorkScheduleInMonthData>> getWorkScheduleInMonth(
      String year, String month) async {
    var request = WorkScheduleInMonthRequest(year, month);
    var response = await request.invoke();
    return response;
  }

  // lấy ds tên công việc
  static Future<List<MstSMKPIPlusData>> getMstSMKPIPlus() async {
    var request = MstSMKPIPlusRequest();
    var response = await request.invoke();
    if (response == []) {
      return [];
    }
    return response;
  }

  // lấy ds nhân viên sở hữu
  static Future<List<UserByDealerData>> getUserByDealer() async {
    try {
      var request = UserByDealerRequest();
      var response = await request.invoke();
      if (response == []) {
        return [];
      }
      return response;
    } catch (e) {
      throw "Lỗi tải dữ liệu !!";
    }
  }

  // tạo workCode
  static Future<String> getWorkCode() async {
    var request = WorkCodeRequest();
    var response = await request.invoke();
    return response.workCode ?? "";
  }

  // lấy danh sách cơ hội
  static Future<List<SPSalesProcessSearchData>> getSPSalesProcessSearch(
    String salesId,
    String fromDate,
    String toDate,
    String fullName,
    String phoneNo,
    String createBy,
    String spStatus,
    int pageIndex,
    int pageCount,
  ) async {
    var request = SPSalesProcessSearchRequest(salesId, fromDate, toDate,
        fullName, phoneNo, createBy, spStatus, pageIndex, pageCount);
    var response = await request.invoke();
    print("response $response");
    return response;
  }

  // lấy danh sách khách hàng
  static Future<List<DealerCustomerContactSearchData>>
      getDealerCustomerContactSearch(
    String fullName,
    String phoneNo,
    int pageIndex,
    int pageCount,
  ) async {
    var request = DealerCustomerContactSearchRequest(
        fullName, phoneNo, pageIndex, pageCount);
    var response = await request.invoke();
    return response;
  }

  // lấy chi tiết công việc
  static Future<List<WorkDetailData>> getWorkDetail(
    String schCode,
  ) async {
    var request = WorkDetailRequest(schCode);
    var response = await request.invoke();
    return response;
  }

  // lưu tạo công việc
  static Future<bool> saveWorkCreate(SaveWork saveWork) async {
    var request = SaveWorkCreateRequest(saveWork);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // lưu update cv
  static Future<bool> saveWorkUpdate(SaveWork saveWork) async {
    var request = SaveWorkUpdateRequest(saveWork);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // xóa cv
  static Future<bool> deleteWork(String schCode) async {
    var request = DeleteWorkRequest(schCode);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // lấy danh sách quản lý cơ hội
  static Future<List<ListElement>> getSalesProcessSearch(
    String fromDate,
    String toDate,
    String cusfullname,
    String thamkhao,
    String quantam,
    String laithu,
    String damphan,
    String kyhd,
    String huy,
    int pageIndex,
    int pageCount,
  ) async {
    var request = SalesProcessSearchRequest(fromDate, toDate, cusfullname,
        thamkhao, quantam, laithu, damphan, kyhd, huy, pageIndex, pageCount);
    var response = await request.invoke();
    print("data ${response.data?.length}");
    return response.data ?? [];
  }

  // tạo saleId
  static Future<String> getSaleId() async {
    var request = SaleIdRequest();
    var response = await request.invoke();
    return response.data ?? "";
  }

  // lấy ds chiến lược marketing
  static Future<List<MarketingStrategyData>> getMarketingStrategy() async {
    var request = MarketingStrategyRequest();
    var response = await request.invoke();
    return response;
  }

  // lấy ds nguồn khách hàng
  static Future<List<CustomerSourceData>> getCustomerSource() async {
    var request = CustomerSourceRequest();
    var response = await request.invoke();
    return response;
  }

  // lấy ds car model
  static Future<List<CarModelData>> getCarModel() async {
    var request = CarModelRequest();
    var response = await request.invoke();
    return response;
  }

  // lấy ds car spec
  static Future<List<CarSpecData>> getCarSpec(String modelCode) async {
    var request = CarSpecRequest(modelCode);
    var response = await request.invoke();
    return response;
  }

  // lấy ds car color
  static Future<List<CarColorData>> getCarColor(String modelCode) async {
    var request = CarColorRequest(modelCode);
    var response = await request.invoke();
    return response;
  }

  // lưu tạo cơ hội
  static Future<bool> saveSPSalesProcessCreate(
      SaveSpSaleProcessData saveSPSalesProcess) async {
    var request = SaveOpportunityCreateRequest(saveSPSalesProcess);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // lưu update cơ hội
  static Future<bool> saveSPSalesProcessUpdate(
      SaveSpSaleProcessData saveSPSalesProcess) async {
    var request = SaveOpportunityUpdateRequest(saveSPSalesProcess);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // hủy cơ hội
  static Future<bool> cancelOpportunity(
      String salesId, String spCancelReasonCode) async {
    var request = CancelOpportunityRequest(salesId, spCancelReasonCode);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // lấy chi tiết cơ hội
  static Future<List<SaveSpSaleProcessData>> getSpSalesProcess(
      String salesId) async {
    var request = SpSalesProcessRequest(salesId);
    var response = await request.invoke();
    return response;
  }

  // lấy ds lý do hủy
  static Future<List<ReasonCancelData>> getReasonCancel(
      String reasonCode) async {
    var request = ReasonCancelRequest(reasonCode);
    var response = await request.invoke();
    return response;
  }

  // lấy ds tỉnh
  static Future<List<MstProvinceData>> getMstProvince() async {
    var request = MstProvinceRequest();
    var response = await request.invoke();
    return response;
  }

  // lấy ds huyện
  static Future<List<MstDistrictData>> getMstDistrict(
      {required String provinceCode}) async {
    var request = MstDistrictRequest(provinceCode);
    var response = await request.invoke();
    return response;
  }

  // lấy ds loại ...
  static Future<List<MstCardTypeData>> getMstCardType() async {
    var request = MstCardTypeRequest();
    var response = await request.invoke();
    return response;
  }

  // lưu tạo mới khách hàng
  static Future<bool> saveDealerCustomerCreate(
      SaveDealerCustomerData saveDealerCustomerData) async {
    var request = SaveDealerCustomerCreateRequest(saveDealerCustomerData);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // lưu cập nhật khách hàng
  static Future<bool> saveDealerCustomerUpdate(
      SaveDealerCustomerData saveDealerCustomerData) async {
    var request = SaveDealerCustomerUpdateRequest(saveDealerCustomerData);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // xóa khách hàng
  static Future<bool> deleteCustomer(String customerCode) async {
    var request = DeleteCustomerRequest(customerCode);
    var response = await request.invoke();
    return response.isSuccess();
  }

  // lấy ds zalo
  static Future<List<ZaloData>> getZalos(String keyword) async {
    var request = ZaloRequest(keyword);
    var response = await request.invoke();
    return response;
  }

  // lấy ds loại khách hàng
  static Future<List<CustomerTypeData>> getCustomerType() async {
    var request = GetCustomerTypeRequest();
    var response = await request.invoke();
    return response;
  }

  // lấy ds nhóm khách hàng
  static Future<List<CustomerGroupTypeData>> getCustomerGroupType() async {
    var request = GetCustomerGroupTypeRequest();
    var response = await request.invoke();
    return response;
  }

  static Future<List<DealerCustomerContactSearchData>> getDealerCustomerSearch(
    String fullName,
    String phoneNo,
    String phonenolh,
    String usercodeowner,
    String dealercode,
    String custypecode,
    String cusgrouptype,
    String provincecode,
    String fromdate,
    String todate,
    int pageIndex,
    int pageCount,
  ) async {
    var request = DealerCustomerSearchRequest(
      fullName,
      phoneNo,
      phonenolh,
      usercodeowner,
      dealercode,
      custypecode,
      cusgrouptype,
      provincecode,
      fromdate,
      todate,
      pageIndex,
      pageCount,
    );
    var response = await request.invoke();
    return response;
  }

  // lấy mã khách hàng
  static Future<GetCustomerNoResponse> getCustomerNoRequest() async {
    try {
      var request = GetCustomerNoRequest();
      var response = await request.invoke();
      return response;
    } catch (e) {
      print("getCustomerNoRequest ERROR");
      rethrow;
    }
  }

  // check số điên thoại
  static Future<CheckPhoneNoResponse> checkPhoneNo(
      String customerCode, String phoneNo) async {
    try {
      var request =
          CheckPhoneNoRequest(customerCode: customerCode, phoneNo: phoneNo);
      var response = await request.invoke();
      return response;
    } catch (e) {
      print("CheckPhoneNoRequest ERROR");
      rethrow;
    }
  }

  // lấy thông tin khách hàng theo CustomerCode
  static Future<List<SaveDealerCustomerData>> getDealerCustomerByCode(
      String customerCode) async {
    try {
      var request = GetDealerCustomerByCodeRequest(customerCode: customerCode);
      var response = await request.invoke();
      return response;
    } catch (e) {
      print("GetDealerCustomerByCodeRequest ERROR");
      rethrow;
    }
  }

  // cập nhật số điện thoại
  static Future<bool> updatePhoneNo(
      SaveDealerCustomerData saveDealerCustomerData) async {
    var request = UpdatePhoneNoRequest(saveDealerCustomerData);
    var response = await request.invoke();
    return response.isSuccess();
  }
}
