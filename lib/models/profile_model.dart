class Profile {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  Profile({this.statusCode, this.success, this.message, this.data});

  Profile.fromJson(Map json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Location? location;
  int? reportCount;
  String? sId;
  String? name;
  String? businessName;
  String? email;
  String? status;
  bool? verified;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? profile;

  Data(
      {this.location,
      this.reportCount,
      this.sId,
      this.name,
      this.businessName,
      this.email,
      this.status,
      this.verified,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    reportCount = json['reportCount'];
    sId = json['_id'];
    name = json['name'];
    businessName = json['businessName'];
    email = json['email'];
    status = json['status'];
    verified = json['verified'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['reportCount'] = reportCount;
    data['_id'] = sId;
    data['name'] = name;
    data['businessName'] = businessName;
    data['email'] = email;
    data['status'] = status;
    data['verified'] = verified;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['profile'] = profile;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
