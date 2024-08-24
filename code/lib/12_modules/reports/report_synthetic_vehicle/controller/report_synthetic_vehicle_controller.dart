import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/11_apis/core/models/car_plan_data.dart';
import 'package:idealer/11_apis/idealer_api_service.dart';

class ReportSyntheticVehicleController
    extends BaseController<List<CarPlanData>> {
  @override
  Future<List<CarPlanData>> load(int loadLimit) async {
    return await IDealerApiService.getReportCarPlan();
  }
}
