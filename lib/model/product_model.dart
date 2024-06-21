class ProductModel {
  ProductModel({
      this.status, 
      this.message, 
      this.data, 
      this.responsecode,});

  ProductModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responsecode = json['responsecode'];
  }
  bool? status;
  String? message;
  Data? data;
  num? responsecode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['responsecode'] = responsecode;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.routeId, 
      this.name, 
      this.description, 
      this.image, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    routeId = json['route_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? routeId;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['route_id'] = routeId;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}