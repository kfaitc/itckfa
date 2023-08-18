class Model_sale_image {
  int? idImage;
  int? propertyTypeId;
  String? imageNameSale;
  String? url;

  Model_sale_image(
      {this.idImage, this.propertyTypeId, this.imageNameSale, this.url});

  Model_sale_image.fromJson(Map<String, dynamic> json) {
    idImage = json['id_image'];
    propertyTypeId = json['property_type_id'];
    imageNameSale = json['image_name_sale'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_image'] = this.idImage;
    data['property_type_id'] = this.propertyTypeId;
    data['image_name_sale'] = this.imageNameSale;
    data['url'] = this.url;
    return data;
  }
}
