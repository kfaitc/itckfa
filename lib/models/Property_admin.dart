// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, camel_case_types, unnecessary_this

class Model_Image_ptys_post {
  int? idImage;
  int? propertyTypeId;
  String? imageName;
  String? url;

  Model_Image_ptys_post(
      {required this.idImage,
      required this.propertyTypeId,
      required this.imageName,
      required this.url});

  Model_Image_ptys_post.fromJson(Map<String, dynamic> json) {
    idImage = json['id_image'];
    propertyTypeId = json['property_type_id'];
    imageName = json['image_name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_image'] = this.idImage;
    data['property_type_id'] = this.propertyTypeId;
    data['image_name'] = this.imageName;
    data['url'] = this.url;
    return data;
  }
}
