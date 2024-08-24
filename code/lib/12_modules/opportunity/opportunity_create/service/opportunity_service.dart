import 'package:idealer/12_modules/opportunity/opportunity_create/model/opportunity_model.dart';

class OpportunityService {
  OpportunityService._private();
  static Future<OpportunityService> instance() async {
    var instance = OpportunityService._private();
    await instance._initialize();
    return instance;
  }

  Future<void> _initialize() async {}

  Future<OpportunityModel> getOpportunityModel() async {
    return OpportunityModel();
  }
}