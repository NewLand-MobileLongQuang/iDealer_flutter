import 'package:idealer/12_modules/customer/create_customer/model/create_customer_data_model.dart';

class CreateCustomerService {
  CreateCustomerService._private();
  static Future<CreateCustomerService> instance() async {
    var instance = CreateCustomerService._private();
    await instance._initialize();
    return instance;
  }

  Future<void> _initialize() async {}

  Future<CreateCustomerDataModel> getCustomerCreateDataModel() async {
    return CreateCustomerDataModel();
  }
}
