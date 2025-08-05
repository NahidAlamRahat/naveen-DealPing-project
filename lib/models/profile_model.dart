class Profile {
  Location? location;
  int? reportCount;
  String? sId;
  String? firstName;
  String? lastName;
  String? businessName;
  String? email;
  String? status;
  bool? verified;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? profile;
  String? eiin;
  String? license;
  String? phone;
  String? address;
  String? city;
  int? zipCode;
  double? rating;
  int? ratingCount;
  String? h3Index;
  int? h3Res;
  Category? category;
  List<SubCategory>? subCategories;

  Profile({
    this.location,
    this.reportCount,
    this.sId,
    this.firstName,
    this.lastName,
    this.businessName,
    this.email,
    this.status,
    this.verified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.profile,
    this.eiin,
    this.license,
    this.phone,
    this.address,
    this.city,
    this.zipCode,
    this.rating,
    this.ratingCount,
    this.h3Index,
    this.h3Res,
    this.category,
    this.subCategories,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      reportCount: json['reportCount'] ?? 0,
      sId: json['_id'] ?? "",
      firstName: json['name'] ?? "",
      lastName: json['lastName'] ?? "",
      businessName: json['businessName'] ?? "",
      email: json['email'] ?? "",
      status: json['status'] ?? "",
      verified: json['verified'] ?? false,
      role: json['role'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      profile: json['profile'] ?? "",
      eiin: json['eiin'] ?? "",
      license: json['license'] ?? "",
      phone: json['phone'] ?? "",
      address: json['address'] ?? "",
      city: json['city'] ?? "",
      zipCode: json['zipCode'] ?? 0,
      rating: (json['rating'] != null) ? json['rating'].toDouble() : 0.0,
      ratingCount: json['ratingCount'] ?? 0,
      h3Index: json['h3Index'],
      h3Res: json['h3Res'] ?? 0,
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      subCategories: json['subCategories'] != null
          ? List<SubCategory>.from(json['subCategories'].map((x) => SubCategory.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['reportCount'] = reportCount;
    data['_id'] = sId;
    data['name'] = firstName;
    data['lastName'] = lastName;
    data['businessName'] = businessName;
    data['email'] = email;
    data['status'] = status;
    data['verified'] = verified;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['profile'] = profile;
    data['eiin'] = eiin;
    data['license'] = license;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    data['zipCode'] = zipCode;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['h3Index'] = h3Index;
    data['h3Res'] = h3Res;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subCategories != null) {
      data['subCategories'] = subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class Category {
  String? sId;
  String? title;
  String? icon;

  Category({this.sId, this.title, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      sId: json['_id'] ?? "",
      title: json['title'] ?? "",
      icon: json['icon'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['icon'] = icon;
    return data;
  }
}

class SubCategory {
  String? sId;
  String? title;

  SubCategory({this.sId, this.title});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      sId: json['_id'] ?? "",
      title: json['title'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}
