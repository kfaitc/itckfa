// ignore_for_file: non_constant_identifier_names

class LandBuildingRequestModel {
  late double comparable_adding_price;

  LandBuildingRequestModel({required comparable_adding_price});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "comparable_adding_price": comparable_adding_price,
    };
    return map;
  }
}
