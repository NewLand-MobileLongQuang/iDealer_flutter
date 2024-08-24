class Access {
  var isMenuCusCreate = false;
  var isMenuCusManager = false;

  var isMenuOpportunityCreate = false;
  var isMenuOpportunityManager = false;

  // var isMenuWorkCreate = false;
  var isMenuWorkSchedule = false;
  var isMenuWorkManager = false;

  var isMenuReportSyntheticVehicle = false;
  var isMenuReportRetain = false;
}

class PermissionIdealer{
  PermissionIdealer._privateConstructor();
  static final PermissionIdealer _singleton = PermissionIdealer._privateConstructor();

  factory PermissionIdealer.instance(){
    return _singleton;
  }

  Access access = Access();

  bool get isPermissionCusCreate{
    if (access.isMenuCusCreate){
      return true;
    }
    return false;
  }

  bool get isPermissionCusManager{
    if (access.isMenuCusManager){
      return true;
    }
    return false;
  }

  bool get isPermissionOpportunityCreate{
    if (access.isMenuOpportunityCreate){
      return true;
    }
    return false;
  }

  bool get isPermissionOpportunityManager{
    if (access.isMenuOpportunityManager){
      return true;
    }
    return false;
  }

  bool get isPermissionReportSyntheticVehicle{
    if (access.isMenuReportSyntheticVehicle){
      return true;
    }
    return false;
  }

  bool get isPermissionReportRetain{
    if (access.isMenuReportRetain){
      return true;
    }
    return false;
  }

  bool get isPermissionWorkSchedule{
    if (access.isMenuWorkSchedule){
      return true;
    }
    return false;
  }

  // bool get isPermissionWorkCreate{
  //   if (access.isMenuWorkCreate){
  //     return true;
  //   }
  //   return true;
  // }

  bool get isPermissionWorkManager{
    if (access.isMenuWorkManager){
      return true;
    }
    return false;
  }
}