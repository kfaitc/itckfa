// ignore_for_file: non_constant_identifier_names, camel_case_types, equal_keys_in_map

class AutoVerbal_property_update {
  final String message;
  AutoVerbal_property_update({
    required this.message,
  });
  factory AutoVerbal_property_update.fromJson(Map<String, dynamic> json) {
    return AutoVerbal_property_update(
      message: json["message"] ?? "",
    );
  }
}

class AutoVerbal_property_update_1 {
  late String id_ptys;
  late String property_type_id;
  late String price;
  late String land;
  late String sqm;
  late String bath;
  late String bed;
  late String type;
  late String address;
  late String title;
  late String description;
  late String hometype;

  //VerbalTypeRequestModel data;
  // List<VerbalTypeRequestModel> autoVerbal;
  AutoVerbal_property_update_1({
    required this.id_ptys,
    required this.property_type_id,
    required this.price,
    required this.land,
    required this.sqm,
    required this.bath,
    required this.bed,
    required this.type,
    required this.address,
    required this.title,
    required this.description,
    required this.hometype,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> verbal_property = {
      "id_ptys": id_ptys,
      "property_type_id": property_type_id,
      "price": price.trim(),
      "land": land.trim(),
      "sqm": sqm.trim(),
      "bath": bath.trim(),
      "bed": bed.trim(),
      "type": type.trim(),
      "address": address.trim(),
      "Title": title.trim(),
      "description": description.trim(),
      "hometype": hometype.trim(),
    };
    return verbal_property;
  }
}

/// For Rent
class AutoVerbal_property_update_Rent {
  final String message;
  AutoVerbal_property_update_Rent({
    required this.message,
  });
  factory AutoVerbal_property_update_Rent.fromJson(Map<String, dynamic> json) {
    return AutoVerbal_property_update_Rent(
      message: json["message"] ?? "",
    );
  }
}

class AutoVerbal_property_update_Rent_k {
  late String id_ptys;
  late String property_type_id;
  late String price;
  late String land;
  late String sqm;
  late String bath;
  late String bed;
  late String type;
  late String address;
  late String title;
  late String description;
  late String hometype;

  //VerbalTypeRequestModel data;
  // List<VerbalTypeRequestModel> autoVerbal;
  AutoVerbal_property_update_Rent_k({
    required this.id_ptys,
    required this.property_type_id,
    required this.price,
    required this.land,
    required this.sqm,
    required this.bath,
    required this.bed,
    required this.type,
    required this.address,
    required this.title,
    required this.description,
    required this.hometype,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> verbal_property = {
      "id_ptys": id_ptys,
      "property_type_id": property_type_id,
      "price": price.trim(),
      "land": land.trim(),
      "sqm": sqm.trim(),
      "bath": bath.trim(),
      "bed": bed.trim(),
      "type": type.trim(),
      "address": address.trim(),
      "Title": title.trim(),
      "description": description.trim(),
      "hometype": hometype.trim(),
    };
    return verbal_property;
  }
}
