// ignore_for_file: non_constant_identifier_names

class ImagePost {
  String? id_p;
  String? id_image;
  String? property_type_id;
  String? image_name_sale;
  String? url;

  ImagePost({
    this.id_p,
    this.id_image,
    this.property_type_id,
    this.image_name_sale,
    this.url,
  });

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(
      id_p: json['id_p'],
      id_image: json['id_image'],
      property_type_id: json['property_type_id'],
      image_name_sale: json['image_name_sale'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id_p': id_p,
        'id_image': id_image,
        'property_type_id': property_type_id,
        'url': image_name_sale,
        'title': url,
      };
}
