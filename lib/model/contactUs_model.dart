class ContactUsModel {
  ContactUsModel({
      this.status, 
      this.message, 
      this.data, 
      this.responsecode,});

  ContactUsModel.fromJson(dynamic json) {
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
      this.name, 
      this.email, 
      this.description, 
      this.phone, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    description = json['description'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? name;
  String? email;
  String? description;
  dynamic phone;
  String? updatedAt;
  String? createdAt;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['description'] = description;
    map['phone'] = phone;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}