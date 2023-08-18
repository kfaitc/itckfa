// ignore_for_file: unnecessary_this, non_constant_identifier_names

class L_B {
  String verbal_land_type, verbal_land_des, verbal_land_dp, address;
  int verbal_landid;
  double verbal_land_area,
      verbal_land_minsqm,
      verbal_land_maxsqm,
      verbal_land_minvalue,
      verbal_land_maxvalue;

  L_B(
      this.verbal_land_type,
      this.verbal_land_des,
      this.verbal_land_dp,
      this.address,
      this.verbal_landid,
      this.verbal_land_area,
      this.verbal_land_minsqm,
      this.verbal_land_maxsqm,
      this.verbal_land_minvalue,
      this.verbal_land_maxvalue);

  factory L_B.fromJson(Map<String, dynamic> json) {
    return L_B(
      json['verbal_land_type'],
      json['verbal_land_des'],
      json['verbal_land_dp'],
      json['address'],
      json['verbal_landid'],
      json['verbal_land_area'],
      json['verbal_land_minsqm'],
      json['verbal_land_maxsqm'],
      json['verbal_land_minvalue'],
      json['verbal_land_maxvalue'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'verbal_land_type': this.verbal_land_type,
      'verbal_land_des': this.verbal_land_des,
      'verbal_land_dp': this.verbal_land_dp,
      'address': this.address,
      'verbal_landid': this.verbal_landid,
      'verbal_land_area': this.verbal_land_area,
      'verbal_land_minsqm': this.verbal_land_minsqm,
      'verbal_land_maxsqm': this.verbal_land_maxsqm,
      'verbal_land_minvalue': this.verbal_land_minvalue,
      'verbal_land_maxvalue': this.verbal_land_maxvalue,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'verbal_land_type': verbal_land_type,
      'verbal_land_des': verbal_land_des,
      'verbal_land_dp': verbal_land_dp,
      'address': address,
      'verbal_landid': verbal_landid,
      'verbal_land_area': verbal_land_area,
      'verbal_land_minsqm': verbal_land_minsqm,
      'verbal_land_maxsqm': verbal_land_maxsqm,
      'verbal_land_minvalue': verbal_land_minvalue,
      'verbal_land_maxvalue': verbal_land_maxvalue,
    };
  }
}
