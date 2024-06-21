class AuthModel {
  AuthModel({
      this.status, 
      this.message, 
      this.data, 
      this.responsecode,});

  AuthModel.fromJson(dynamic json) {
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
      this.token,});

  Data.fromJson(dynamic json) {
    token = json['token'];
  }
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}