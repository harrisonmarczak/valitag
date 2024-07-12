class NFCRouteScanModel {
  bool? status;
  String? message;
  Data? data;
  int? responsecode;

  NFCRouteScanModel({this.status, this.message, this.data, this.responsecode});

  NFCRouteScanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responsecode'] = responsecode;
    return data;
  }
}

class Data {
  int? id;
  String? nfcId;
  String? addressNfcId;
  String? userId;
  String? image;
  String? name;
  String? address;
  String? datetime;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.nfcId,
        this.addressNfcId,
        this.userId,
        this.image,
        this.name,
        this.address,
        this.datetime,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nfcId = json['nfc_id'];
    addressNfcId = json['address_nfc_id'];
    userId = json['user_id'];
    image = json['image'];
    name = json['name'];
    address = json['address'];
    datetime = json['datetime'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nfc_id'] = nfcId;
    data['address_nfc_id'] = addressNfcId;
    data['user_id'] = userId;
    data['image'] = image;
    data['name'] = name;
    data['address'] = address;
    data['datetime'] = datetime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
