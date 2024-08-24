import 'package:idealer/04_core_modules/user_session/api/base/response/base_response.dart';

class SelectOrgResponse extends BaseResponse{
  List<LstOSInosOrg>? lstOSInosOrg;

  SelectOrgResponse({ this.lstOSInosOrg});

  SelectOrgResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['Lst_OS_Inos_Org'] != null) {
      lstOSInosOrg = <LstOSInosOrg>[];
      json['Lst_OS_Inos_Org'].forEach((v) {
        lstOSInosOrg!.add(LstOSInosOrg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.lstOSInosOrg != null) {
      data['Lst_OS_Inos_Org'] =
          this.lstOSInosOrg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstOSInosOrg {
  String? id;
  String? parentId;
  String? name;
  String? bizType;
  String? bizField;
  String? orgSize;
  String? contactName;
  String? email;
  Null? phoneNo;
  Null? description;
  String? enable;
  String? currentUserRole;
  Null? flagActive;
  Null? logLUDTimeUTC;
  Null? logLUBy;
  String? flagNetworkExist;

  LstOSInosOrg(
      {this.id,
        this.parentId,
        this.name,
        this.bizType,
        this.bizField,
        this.orgSize,
        this.contactName,
        this.email,
        this.phoneNo,
        this.description,
        this.enable,
        this.currentUserRole,
        this.flagActive,
        this.logLUDTimeUTC,
        this.logLUBy,
        this.flagNetworkExist});

  LstOSInosOrg.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    parentId = json['ParentId'];
    name = json['Name'];
    bizType = json['BizType'];
    bizField = json['BizField'];
    orgSize = json['OrgSize'];
    contactName = json['ContactName'];
    email = json['Email'];
    phoneNo = json['PhoneNo'];
    description = json['Description'];
    enable = json['Enable'];
    currentUserRole = json['CurrentUserRole'];
    flagActive = json['FlagActive'];
    logLUDTimeUTC = json['LogLUDTimeUTC'];
    logLUBy = json['LogLUBy'];
    flagNetworkExist = json['FlagNetworkExist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ParentId'] = this.parentId;
    data['Name'] = this.name;
    data['BizType'] = this.bizType;
    data['BizField'] = this.bizField;
    data['OrgSize'] = this.orgSize;
    data['ContactName'] = this.contactName;
    data['Email'] = this.email;
    data['PhoneNo'] = this.phoneNo;
    data['Description'] = this.description;
    data['Enable'] = this.enable;
    data['CurrentUserRole'] = this.currentUserRole;
    data['FlagActive'] = this.flagActive;
    data['LogLUDTimeUTC'] = this.logLUDTimeUTC;
    data['LogLUBy'] = this.logLUBy;
    data['FlagNetworkExist'] = this.flagNetworkExist;
    return data;
  }
}
