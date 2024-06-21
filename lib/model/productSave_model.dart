class ProductSaveModel {
  ProductSaveModel({
      this.status, 
      this.message, 
      this.data, 
      this.responsecode,});

  ProductSaveModel.fromJson(dynamic json) {
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
      this.productId, 
      this.description, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    productId = json['product_id'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? productId;
  String? description;
  String? updatedAt;
  String? createdAt;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['description'] = description;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}