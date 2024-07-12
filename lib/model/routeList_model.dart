class RouteListModel {
  bool? status;
  String? message;
  List<Data>? data;
  int? responsecode;

  RouteListModel({this.status, this.message, this.data, this.responsecode});

  RouteListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    responsecode = json['responsecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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


// class RouteListModel {
//   RouteListModel({
//       this.status,
//       this.message,
//       this.data,
//       this.responsecode,});
//
//   RouteListModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(Data.fromJson(v));
//       });
//     }
//     responsecode = json['responsecode'];
//   }
//   bool? status;
//   String? message;
//   List<Data>? data;
//   num? responsecode;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['responsecode'] = responsecode;
//     return map;
//   }
//
// }
//
// class Data {
//   Data({
//       this.id,
//       this.userId,
//       this.name,
//       this.address,
//       this.datetime,
//       this.createdAt,
//       this.updatedAt,});
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     address = json['address'];
//     datetime = json['datetime'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//   num? id;
//   String? userId;
//   String? name;
//   String? address;
//   String? datetime;
//   String? createdAt;
//   String? updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['user_id'] = userId;
//     map['name'] = name;
//     map['address'] = address;
//     map['datetime'] = datetime;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     return map;
//   }
//
// }