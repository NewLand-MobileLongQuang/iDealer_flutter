import 'package:idealer/04_core_modules/user_session/api/base/request/idealer_api_request2.dart';
import 'package:idealer/04_core_modules/user_session/user_session.dart';
import 'package:idealer/11_apis/core/models/work_schedule_in_month_data.dart';

class WorkScheduleInMonthRequest extends IdealerApiRequest2 {
  WorkScheduleInMonthRequest(
    String year,
    String month,
  ) {
    endpoint = "Services/ShowCalendar";
    
    addParam("year", year);
    addParam("month", month);
  }

  Future<List<WorkScheduleInMonthData>> invoke() async {
    var response = await super.coreInvoke();
    List<WorkScheduleInMonthData> data = (response as List<dynamic>)
        .map((e) => WorkScheduleInMonthData.fromJson(e as Map<String, dynamic>))
        .toList();
    return data;
  }
}
