class RouteListModel {
  RouteListModel({
      this.status, 
      this.message, 
      this.data, 
      this.responsecode,});

  RouteListModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
  }
  bool? status;
  String? message;
  List<Data>? data;
  num? responsecode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['responsecode'] = responsecode;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.userId, 
      this.name, 
      this.address, 
      this.datetime, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    datetime = json['datetime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userId;
  String? name;
  String? address;
  String? datetime;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['address'] = address;
    map['datetime'] = datetime;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}