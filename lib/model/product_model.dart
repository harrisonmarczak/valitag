class ProductModel {
  bool? status;
  String? message;
  Data? data;
  int? responsecode;

  ProductModel({this.status, this.message, this.data, this.responsecode});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  Route? route;
  List<AssetsImages>? assetsImages;
  List<AssetsNotes>? assetsNotes;

  Data({this.route, this.assetsImages, this.assetsNotes});

  Data.fromJson(Map<String, dynamic> json) {
    route = json['route'] != null ? Route.fromJson(json['route']) : null;
    if (json['assetsImages'] != null) {
      assetsImages = <AssetsImages>[];
      json['assetsImages'].forEach((v) {
        assetsImages!.add(AssetsImages.fromJson(v));
      });
    }
    if (json['assetsNotes'] != null) {
      assetsNotes = <AssetsNotes>[];
      json['assetsNotes'].forEach((v) {
        assetsNotes!.add(AssetsNotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (route != null) {
      data['route'] = route!.toJson();
    }
    if (assetsImages != null) {
      data['assetsImages'] = assetsImages!.map((v) => v.toJson()).toList();
    }
    if (assetsNotes != null) {
      data['assetsNotes'] = assetsNotes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Route {
  int? id;
  String? userId;
  String? image;
  String? name;
  String? address;
  String? datetime;
  int? status;
  String? createdAt;
  String? updatedAt;

  Route(
      {this.id,
        this.userId,
        this.image,
        this.name,
        this.address,
        this.datetime,
        this.status,
        this.createdAt,
        this.updatedAt});

  Route.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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

class AssetsImages {
  int? id;
  String? routeId;
  String? assetsNoteId;
  String? image;
  String? createdAt;
  String? updatedAt;

  AssetsImages(
      {this.id,
        this.routeId,
        this.assetsNoteId,
        this.image,
        this.createdAt,
        this.updatedAt});

  AssetsImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['route_id'];
    assetsNoteId = json['assets_note_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_id'] = routeId;
    data['assets_note_id'] = assetsNoteId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AssetsNotes {
  int? id;
  int? routeId;
  // Null? productId;
  String? description;
  String? createdAt;
  String? updatedAt;

  AssetsNotes(
      {this.id,
        this.routeId,
        // this.productId,
        this.description,
        this.createdAt,
        this.updatedAt});

  AssetsNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['route_id'];
    // productId = json['product_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_id'] = routeId;
    // data['product_id'] = productId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}




// class ProductModel {
//   ProductModel({
//       this.status,
//       this.message,
//       this.data,
//       this.responsecode,});
//
//   ProductModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     responsecode = json['responsecode'];
//   }
//   bool? status;
//   String? message;
//   Data? data;
//   num? responsecode;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.toJson();
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
//       this.routeId,
//       this.name,
//       this.description,
//       this.image,
//       this.createdAt,
//       this.updatedAt,this.route});
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     routeId = json['route_id'];
//     name = json['name'];
//     description = json['description'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     route = json['route'] != null ? Route.fromJson(json['route']) : null;
//   }
//   num? id;
//   String? routeId;
//   String? name;
//   String? description;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//   Route? route;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['route_id'] = routeId;
//     map['name'] = name;
//     map['description'] = description;
//     map['image'] = image;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     if (route != null) {
//       map['route'] = route!.toJson();
//     }
//     return map;
//   }
//
// }
// class Route {
//   int? id;
//   String? userId;
//   String? name;
//   String? address;
//   String? datetime;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Route(
//       {this.id,
//         this.userId,
//         this.name,
//         this.address,
//         this.datetime,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Route.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     address = json['address'];
//     datetime = json['datetime'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['name'] = name;
//     data['address'] = address;
//     data['datetime'] = datetime;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }