import 'package:get/get.dart';
import 'package:idealer/03_app_config/app_config.dart';
import 'package:idealer/11_apis/core/models/code_name.dart';
import 'package:idealer/11_apis/core/models/customer_source_data.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';
import 'package:idealer/11_apis/core/models/marketing_strategy_data.dart';
import 'package:idealer/11_apis/core/models/sp_sales_process_search_data.dart';

class OpportunityModel {
  OpportunityModel() {}

  // Rx<String> contractPlanDate = "".obs;

  Rx<String> saleId = "".obs;
  Rx<String> createDate =
      AppConfig.instance().dateFormat.format(DateTime.now()).obs;
  Rx<CodeName> status = CodeName("", "").obs;
  Rx<CodeName> carMode = CodeName("", "").obs;
  Rx<double> budgetPlan = 0.0.obs;
  Rx<MarketingStrategyData> marketingData = MarketingStrategyData().obs;
  Rx<CustomerSourceData> cusSourceData = CustomerSourceData().obs;
  Rx<DealerCustomerContactSearchData> dealerCusContract =
      DealerCustomerContactSearchData().obs;
  Rx<String> planSignContractDate = "".obs;
  Rx<String> remark = "".obs;
  List<ListSalesProcessDtl> sPSalesProcessDtls = [];

  void clearData() {
    saleId = "".obs;
    status = CodeName("", "").obs;
    carMode = CodeName("", "").obs;
    budgetPlan = 0.0.obs;
    marketingData = MarketingStrategyData().obs;
    cusSourceData = CustomerSourceData().obs;
    dealerCusContract = DealerCustomerContactSearchData().obs;
    planSignContractDate = "".obs;
    remark = "".obs;
    sPSalesProcessDtls = [];
  }
}
