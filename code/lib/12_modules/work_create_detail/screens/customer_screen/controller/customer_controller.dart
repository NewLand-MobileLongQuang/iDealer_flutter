
import 'package:get/get.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/11_apis/core/models/dealer_customer_contact_search_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';

class CustomerController extends BaseController<List<DealerCustomerContactSearchData>> {
  List<DealerCustomerContactSearchData> customers = [DealerCustomerContactSearchData()];

  @override
  Future<List<DealerCustomerContactSearchData>> load(int loadLimit) async{
    customers = await IDealerApiService.getDealerCustomerContactSearch(fullName.value, phoneNo.value, 0, loadLimit);
    if (customers.isEmpty){
      customers = [DealerCustomerContactSearchData()];
    }
    return customers;
  }

  void setReload(CustomerController controller){
    controller.reload();
  }

  Rx<String> fullName = "".obs;
  Rx<String> phoneNo = "".obs;

}