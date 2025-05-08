import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  int? statusCode;
  bool? success;
  String? message;
  List<AllOffers>? data;

  Welcome({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AllOffers>.from(
                json["data"]!.map((x) => AllOffers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllOffers {
  String? id;
  Business? business;
  String? title;
  String? description;
  int? discount;
  bool? datumDefault;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AllOffers({
    this.id,
    this.business,
    this.title,
    this.description,
    this.discount,
    this.datumDefault,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AllOffers.fromJson(Map<String, dynamic> json) => AllOffers(
        id: json["_id"],
        business: json["business"] == null
            ? null
            : Business.fromJson(json["business"]),
        title: json["title"],
        description: json["description"],
        discount: json["discount"],
        datumDefault: json["default"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "business": business?.toJson(),
        "title": title,
        "description": description,
        "discount": discount,
        "default": datumDefault,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Business {
  String? id;
  String? businessName;
  Location? location;

  Business({
    this.id,
    this.businessName,
    this.location,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["_id"],
        businessName: json["businessName"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "businessName": businessName,
        "location": location?.toJson(),
      };
}

class Location {
  String? type;
  List<int>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<int>.from(json["coordinates"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
