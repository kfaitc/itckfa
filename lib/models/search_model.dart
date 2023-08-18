// ignore_for_file: non_constant_identifier_names
class SearchRequestModel {
  late String property_type_id;
  late String num;
  late String lat;
  late String lng;
  late String distance;
  late String land_min;
  late String land_max;
  late String fromDate;
  late String toDate;
  late String comparable_road;

  SearchRequestModel({
    required this.property_type_id,
    required this.num,
    required this.lat,
    required this.lng,
    required this.land_min,
    required this.land_max,
    required this.distance,
    required this.fromDate,
    required this.toDate,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "property_type_id": property_type_id.trim(),
      "num": num.trim(),
      "lat": lat.trim(),
      "lng": lng.trim(),
      "land_min": land_min.trim(),
      "land_max": land_max.trim(),
      "distance": distance.trim(),
      "verbalFromDate": fromDate.trim(),
      "verbalToDate": toDate.trim(),
    };
    return map;
  }
}
