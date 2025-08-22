class BookingResponseModel {
  final String offerTitle;
  final String offerDescription;
  final Category category;
  final List<String> subCategories;
  final User user;
  final Request request;
  final String chat;
  final Business business;
  final String status;
  final String id;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingResponseModel({
    required this.offerTitle,
    required this.offerDescription,
    required this.category,
    required this.subCategories,
    required this.user,
    required this.request,
    required this.chat,
    required this.business,
    required this.status,
    required this.id,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      offerTitle: json['offerTitle'] ?? '',
      offerDescription: json['offerDescription'] ?? '',
      category: Category.fromJson(json['category']),
      subCategories: List<String>.from(json['subCategories']),
      user: User.fromJson(json['user']),
      request: Request.fromJson(json['request']),
      chat: json['chat'] ?? '',
      business: Business.fromJson(json['business']),
      status: json['status'] ?? '',
      id: json['_id'] ?? '',
      code: json['code'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// অন্যান্য nested models:
class Category {
  final String id;
  final String title;
  Category({required this.id, required this.title});
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['_id'] ?? '',
    title: json['title'] ?? '',
  );
}

class User {
  final String id;
  final String name;
  final String profile;
  User({required this.id, required this.name, required this.profile});
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    profile: json['profile'] ?? '',
  );
}

class Request {
  final String id;
  final String user;
  final String category;
  final List<String> subCategories;
  final String message;
  final List<String> businesses;
  Request({
    required this.id,
    required this.user,
    required this.category,
    required this.subCategories,
    required this.message,
    required this.businesses,
  });
  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json['_id'] ?? '',
    user: json['user'] ?? '',
    category: json['category'] ?? '',
    subCategories: List<String>.from(json['subCategories']),
    message: json['message'] ?? '',
    businesses: List<String>.from(json['businesses']),
  );
}

class Business {
  final String id;
  final String name;
  final String businessName;
  final double rating;
  final int ratingCount;
  final String address;
  final String profile;

  Business({
    required this.id,
    required this.name,
    required this.businessName,
    required this.rating,
    required this.ratingCount,
    required this.address,
    required this.profile,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    businessName: json['businessName'] ?? '',
    rating: (json['rating'] ?? 0).toDouble(),
    ratingCount: json['ratingCount'] ?? 0,
    address: json['address'] ?? '',
    profile: json['profile'] ?? '',
  );
}
