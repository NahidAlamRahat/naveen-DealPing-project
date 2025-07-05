class UserDataModel {
  final Location location;
  final int rating;
  final int ratingCount;
  final String profile;
  final String id;
  final String name;
  final String lastName;
  final String email;
  final List<dynamic> subCategories;
  final String address;
  final String city;
  final int zipCode;
  final String status;
  final bool verified;
  final int reportCount;
  final dynamic h3Index;
  final int h3Res;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserDataModel({
    required this.location,
    required this.rating,
    required this.ratingCount,
    required this.profile,
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.subCategories,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.status,
    required this.verified,
    required this.reportCount,
    this.h3Index,
    required this.h3Res,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      location: Location.fromJson(json['location']),
      rating: json['rating'],
      ratingCount: json['ratingCount'],
      profile: json['profile'],
      id: json['_id'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      subCategories: json['subCategories'] ?? [],
      address: json['address'],
      city: json['city'],
      zipCode: json['zipCode'],
      status: json['status'],
      verified: json['verified'],
      reportCount: json['reportCount'],
      h3Index: json['h3Index'],
      h3Res: json['h3Res'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}
