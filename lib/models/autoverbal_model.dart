class AutoModels {
  int? perPage;
  int? lastPage;
  int? to;
  int? total;
  List<Data>? data;
  AutoModels({
    this.perPage,
    this.lastPage,
    this.to,
    this.total,
    this.data,
  });
  AutoModels.fromJson(Map<String, dynamic> json) {
    perPage = json['perPage'];
    lastPage = json['lastPage'];
    to = json['to'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['perPage'] = perPage;
    data['lastPage'] = lastPage;
    data['to'] = to;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? verbalId;
  String? titleNumber;
  String? approvel;
  String? agentName;
  int? agentId;
  int? protectID;
  int? verbalPropertyId;
  int? borey;
  int? road;
  int? verbalBankId;
  int? verbalBankBranchId;
  String? verbalBankContact;
  String? verbalOwner;
  String? verbalContact;
  String? verbalDate;
  String? verbalBankOfficer;
  String? verbalAddress;
  int? verbalProvinceId;
  String? provincesName;
  int? verbalApproveId;
  int? verbalApprovesId;
  String? verbalComment;
  double? latlongLog;
  double? latlongLa;
  int? verbalCom;
  int? verbalCon;
  int? verbalOption;
  int? verbalStatusId;
  int? verbalUser;
  int? verbalComp;
  String? verifyAgent;
  String? verbalCreatedBy;
  String? verbalCreatedDate;
  String? verbalModifyBy;
  String? verbalKhan;
  int? propertyTypeId;
  String? propertyTypeName;
  int? propertyTypePublished;
  String? propertyTypeColor;
  String? propertyColos;
  String? bankAcronym;
  String? bankBranchName;
  String? bankName;
  String? bankofficer;
  String? bankcontact;
  int? bankProvinceId;
  int? bankDistrictId;
  int? bankCommuneId;
  String? bankVillage;
  int? approveId;
  String? approveName;
  int? agenttypeId;
  String? agenttypeName;
  String? agentTypePhone;
  String? agentTypeEmail;
  int? id;
  String? controlUser;
  String? firstName;
  String? lastName;
  String? username;
  String? gender;
  String? telNum;
  String? knownFrom;
  void clear() {
    verbalId = null;
    titleNumber = null;
    approvel = null;
    agentName = null;
    agentId = null;
    protectID = null;
    verbalPropertyId = null;
    borey = null;
    road = null;
    verbalBankId = null;
    verbalBankBranchId = null;
    verbalBankContact = null;
    verbalOwner = null;
    verbalContact = null;
    verbalDate = null;
    verbalBankOfficer = null;
    verbalAddress = null;
    verbalProvinceId = null;
    provincesName = null;
    verbalApproveId = null;
    verbalApprovesId = null;
    verbalComment = null;
    latlongLog = null;
    latlongLa = null;
    verbalCom = null;
    verbalCon = null;
    verbalOption = null;
    verbalStatusId = null;
    verbalUser = null;
    verbalComp = null;
    verifyAgent = null;
    verbalCreatedBy = null;
    verbalCreatedDate = null;
    verbalModifyBy = null;
    verbalKhan = null;
    propertyTypeId = null;
    propertyTypeName = null;
    propertyTypePublished = null;
    propertyTypeColor = null;
    propertyColos = null;
    bankAcronym = null;
    bankBranchName = null;
    bankName = null;
    bankofficer = null;
    bankcontact = null;
    bankProvinceId = null;
    bankDistrictId = null;
    bankCommuneId = null;
    bankVillage = null;
    approveId = null;
    approveName = null;
    agenttypeId = null;
    agenttypeName = null;
    agentTypePhone = null;
    agentTypeEmail = null;
    id = null;
    controlUser = null;
    firstName = null;
    lastName = null;
    username = null;
    gender = null;
    telNum = null;
    knownFrom = null;
  }

  Data(
      {this.verbalId,
      this.titleNumber,
      this.approvel,
      this.agentName,
      this.agentId,
      this.protectID,
      this.verbalPropertyId,
      this.borey,
      this.road,
      this.verbalBankId,
      this.verbalBankBranchId,
      this.verbalBankContact,
      this.verbalOwner,
      this.verbalContact,
      this.verbalDate,
      this.verbalBankOfficer,
      this.verbalAddress,
      this.verbalProvinceId,
      this.provincesName,
      this.verbalApproveId,
      this.verbalApprovesId,
      this.verbalComment,
      this.latlongLog,
      this.latlongLa,
      this.verbalCom,
      this.verbalCon,
      this.verbalOption,
      this.verbalStatusId,
      this.verbalUser,
      this.verbalComp,
      this.verifyAgent,
      this.verbalCreatedBy,
      this.verbalCreatedDate,
      this.verbalModifyBy,
      this.verbalKhan,
      this.propertyTypeId,
      this.propertyTypeName,
      this.propertyTypePublished,
      this.propertyTypeColor,
      this.propertyColos,
      this.bankAcronym,
      this.bankBranchName,
      this.bankName,
      this.bankofficer,
      this.bankcontact,
      this.bankProvinceId,
      this.bankDistrictId,
      this.bankCommuneId,
      this.bankVillage,
      this.approveId,
      this.approveName,
      this.agenttypeId,
      this.agenttypeName,
      this.agentTypePhone,
      this.agentTypeEmail,
      this.id,
      this.controlUser,
      this.firstName,
      this.lastName,
      this.username,
      this.gender,
      this.telNum,
      this.knownFrom});

  Data.fromJson(Map<String, dynamic> json) {
    verbalId = json['verbal_id'];
    titleNumber = json['title_number'];
    approvel = json['approvel'];
    agentName = json['agent_name'];
    agentId = json['agent_id'];
    protectID = json['protectID'];
    verbalPropertyId = json['verbal_property_id'];
    borey = json['borey'];
    road = json['road'];
    verbalBankId = json['verbal_bank_id'];
    verbalBankBranchId = json['verbal_bank_branch_id'];
    verbalBankContact = json['verbal_bank_contact'];
    verbalOwner = json['verbal_owner'];
    verbalContact = json['verbal_contact'];
    verbalDate = json['verbal_date'];
    verbalBankOfficer = json['verbal_bank_officer'];
    verbalAddress = json['verbal_address'];
    verbalProvinceId = json['verbal_province_id'];
    provincesName = json['provinces_name'];
    verbalApproveId = json['verbal_approve_id'];
    verbalApprovesId = json['verbal_approves_id'];
    verbalComment = json['verbal_comment'];
    latlongLog = json['latlong_log'];
    latlongLa = json['latlong_la'];
    verbalCom = json['verbal_com'];
    verbalCon = json['verbal_con'];
    verbalOption = json['verbal_option'];
    verbalStatusId = json['verbal_status_id'];
    verbalUser = json['verbal_user'];
    verbalComp = json['verbal_comp'];
    verifyAgent = json['VerifyAgent'];
    verbalCreatedBy = json['verbal_created_by'];
    verbalCreatedDate = json['verbal_created_date'];
    verbalModifyBy = json['verbal_modify_by'];
    verbalKhan = json['verbal_khan'];
    propertyTypeId = json['property_type_id'];
    propertyTypeName = json['property_type_name'];
    propertyTypePublished = json['property_type_published'];
    propertyTypeColor = json['property_type_color'];
    propertyColos = json['property_colos'];
    bankAcronym = json['bank_acronym'];
    bankBranchName = json['bank_branch_name'];
    bankName = json['bank_name'];
    bankofficer = json['bankofficer'];
    bankcontact = json['bankcontact'];
    bankProvinceId = json['bank_province_id'];
    bankDistrictId = json['bank_district_id'];
    bankCommuneId = json['bank_commune_id'];
    bankVillage = json['bank_village'];
    approveId = json['approve_id'];
    approveName = json['approve_name'];
    agenttypeId = json['agenttype_id'];
    agenttypeName = json['agenttype_name'];
    agentTypePhone = json['agent_type_phone'];
    agentTypeEmail = json['agent_type_email'];
    id = json['id'];
    controlUser = json['control_user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    gender = json['gender'];
    telNum = json['tel_num'];
    knownFrom = json['known_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verbal_id'] = verbalId;
    data['title_number'] = titleNumber;
    data['approvel'] = approvel;
    data['agent_name'] = agentName;
    data['agent_id'] = agentId;
    data['protectID'] = protectID;
    data['verbal_property_id'] = verbalPropertyId;
    data['borey'] = borey;
    data['road'] = road;
    data['verbal_bank_id'] = verbalBankId;
    data['verbal_bank_branch_id'] = verbalBankBranchId;
    data['verbal_bank_contact'] = verbalBankContact;
    data['verbal_owner'] = verbalOwner;
    data['verbal_contact'] = verbalContact;
    data['verbal_date'] = verbalDate;
    data['verbal_bank_officer'] = verbalBankOfficer;
    data['verbal_address'] = verbalAddress;
    data['verbal_province_id'] = verbalProvinceId;
    data['provinces_name'] = provincesName;
    data['verbal_approve_id'] = verbalApproveId;
    data['verbal_approves_id'] = verbalApprovesId;
    data['verbal_comment'] = verbalComment;
    data['latlong_log'] = latlongLog;
    data['latlong_la'] = latlongLa;
    data['verbal_com'] = verbalCom;
    data['verbal_con'] = verbalCon;
    data['verbal_option'] = verbalOption;
    data['verbal_status_id'] = verbalStatusId;
    data['verbal_user'] = verbalUser;
    data['verbal_comp'] = verbalComp;
    data['VerifyAgent'] = verifyAgent;
    data['verbal_created_by'] = verbalCreatedBy;
    data['verbal_created_date'] = verbalCreatedDate;
    data['verbal_modify_by'] = verbalModifyBy;
    data['verbal_khan'] = verbalKhan;
    data['property_type_id'] = propertyTypeId;
    data['property_type_name'] = propertyTypeName;
    data['property_type_published'] = propertyTypePublished;
    data['property_type_color'] = propertyTypeColor;
    data['property_colos'] = propertyColos;
    data['bank_acronym'] = bankAcronym;
    data['bank_branch_name'] = bankBranchName;
    data['bank_name'] = bankName;
    data['bankofficer'] = bankofficer;
    data['bankcontact'] = bankcontact;
    data['bank_province_id'] = bankProvinceId;
    data['bank_district_id'] = bankDistrictId;
    data['bank_commune_id'] = bankCommuneId;
    data['bank_village'] = bankVillage;
    data['approve_id'] = approveId;
    data['approve_name'] = approveName;
    data['agenttype_id'] = agenttypeId;
    data['agenttype_name'] = agenttypeName;
    data['agent_type_phone'] = agentTypePhone;
    data['agent_type_email'] = agentTypeEmail;
    data['id'] = id;
    data['control_user'] = controlUser;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['gender'] = gender;
    data['tel_num'] = telNum;
    data['known_from'] = knownFrom;
    return data;
  }
}
