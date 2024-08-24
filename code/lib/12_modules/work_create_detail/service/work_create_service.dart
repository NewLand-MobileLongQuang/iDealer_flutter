import 'package:idealer/12_modules/work_create_detail/model/work_create_data_model.dart';

class WorkCreateService {
  WorkCreateService._private();
  static Future<WorkCreateService> instance() async {
    var instance = WorkCreateService._private();
    await instance._initialize();
    return instance;
  }

  Future<void> _initialize() async {}

  Future<WorkCreateDataModel> getWorkCreateDataModel() async {
    return WorkCreateDataModel();
  }
}
