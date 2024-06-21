class RouteListResponse {
  String? id;
  String? name;
  String? downloadTime;
  List<Inspections>? inspections;

  RouteListResponse({this.id, this.name, this.downloadTime, this.inspections});

  RouteListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    downloadTime = json['downloadTime'];
    if (json['inspections'] != null) {
      inspections = <Inspections>[];
      json['inspections'].forEach((v) {
        inspections!.add(new Inspections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['downloadTime'] = this.downloadTime;
    if (this.inspections != null) {
      data['inspections'] = this.inspections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inspections {
  String? id;
  String? assetId;
  String? earliest;
  String? latest;
  String? additionalInfo;

  Inspections(
      {this.id, this.assetId, this.earliest, this.latest, this.additionalInfo});

  Inspections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assetId = json['assetId'];
    earliest = json['earliest'];
    latest = json['latest'];
    additionalInfo = json['additionalInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assetId'] = this.assetId;
    data['earliest'] = this.earliest;
    data['latest'] = this.latest;
    data['additionalInfo'] = this.additionalInfo;
    return data;
  }
}

class RouteDetailsModal {
  String? id;
  String? assetNo;
  String? name;
  String? latitude;
  String? longitude;

  RouteDetailsModal(
      {this.id, this.assetNo, this.name, this.latitude, this.longitude});

  RouteDetailsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assetNo = json['assetNo'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assetNo'] = this.assetNo;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
