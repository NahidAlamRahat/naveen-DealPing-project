

class Profile {
  Location? location;
  int? reportCount;
  String? sId;
  String? name;
  String? lastName;
  String? businessName;
  String? email;
  String? status;
  bool? verified;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? profile;

  Profile(
      {this.location,
        this.reportCount,
        this.sId,
        this.name,
        this.lastName,
        this.businessName,
        this.email,
        this.status,
        this.verified,
        this.role,
        this.createdAt,
        this.updatedAt,

        this.profile});

factory  Profile.fromJson(Map<String, dynamic> json) {
return Profile(
    location :
    json['location'] != null ? Location.fromJson(json['location']) : null,
    reportCount : json['reportCount'] ?? "",
    sId : json['_id'] ?? "",
    name : json['name'] ?? "",
    lastName : json['lastName'] ?? "",
    businessName : json['businessName'] ?? "",
    email : json['email'] ?? "",
    status : json['status'] ?? "",
    verified : json['verified'] ?? "",
    role : json['role'] ?? "",
    createdAt : json['createdAt'] ?? "",
    updatedAt : json['updatedAt'] ?? "",
profile : json['profile'] ?? "",
);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['reportCount'] = reportCount;
    data['_id'] = sId;
    data['name'] = name;
    data['lastName'] = lastName;
    data['businessName'] = businessName;
    data['email'] = email;
    data['status'] = status;
    data['verified'] = verified;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
