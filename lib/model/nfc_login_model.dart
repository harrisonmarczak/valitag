class NFCLoginModel {
  bool? status;
  String? message;
  Data? data;
  int? responsecode;

  NFCLoginModel({this.status, this.message, this.data, this.responsecode});

  NFCLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responsecode'] = this.responsecode;
    return data;
  }
}

class Data {
  int? id;
  String? nfcid;
  // Null? name;
  // Null? email;
  // Null? mobile;
  // Null? emailVerifiedAt;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? token;

  Data(
      {this.id,
        this.nfcid,
        // this.name,
        // this.email,
        // this.mobile,
        // this.emailVerifiedAt,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nfcid = json['nfcid'];
    // name = json['name'];
    // email = json['email'];
    // mobile = json['mobile'];
    // emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nfcid'] = this.nfcid;
    // data['name'] = this.name;
    // data['email'] = this.email;
    // data['mobile'] = this.mobile;
    // data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
