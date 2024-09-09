class ImageDBModel {
  int? id;
  String? image;

  ImageDBModel({this.id, this.image});

  ImageDBModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
