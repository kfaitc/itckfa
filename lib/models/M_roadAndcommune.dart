class roadAndcommune {
  int? rid;
  int? cid;
  double? maxvalue;
  double? minvalue;

  roadAndcommune({this.rid, this.cid, this.maxvalue, this.minvalue});

  roadAndcommune.fromJson(Map<String, dynamic> json) {
    rid = json['rid'];
    cid = json['cid'];
    maxvalue = json['max_value'];
    minvalue = json['min_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rid'] = rid;
    data['cid'] = cid;
    data['max_value'] = maxvalue;
    data['min_value'] = minvalue;
    return data;
  }
}

class roadAndcommune_ReponeModel {
  final String message;
  roadAndcommune_ReponeModel({
    required this.message,
  });
  factory roadAndcommune_ReponeModel.fromJson(Map<String, dynamic> json) {
    return roadAndcommune_ReponeModel(
      message: json["message"] ?? "",
    );
  }
}
