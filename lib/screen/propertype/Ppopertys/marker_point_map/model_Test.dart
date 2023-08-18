// ignore_for_file: unnecessary_this

class Model_Test_Pov {
  List<Products>? products;

  Model_Test_Pov({this.products});

  Model_Test_Pov.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? image;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? sex;

  Products(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.sex});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sex = json['Sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['Sex'] = this.sex;
    return data;
  }
}
