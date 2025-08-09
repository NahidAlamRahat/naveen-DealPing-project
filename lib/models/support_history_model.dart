class SupportHistoryModel {
  final String? id;
  final User? user;
  final List<Subcategory>? prevSubcategories;
  final List<Subcategory>? subcategories;
  final String? prevBusinessName;
  final String? businessName;
  final Category? prevCategory;
  final Category? category;
  final List<String> types;
  final String? status;
  final String? prevEiin;
  final String? eiin;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  SupportHistoryModel({
    this.id,
    this.user,
    this.prevSubcategories,
    this.subcategories,
    this.prevBusinessName,
    this.businessName,
    this.prevCategory,
    this.category,
    required this.types,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.eiin,
    this.prevEiin,
  });

  factory SupportHistoryModel.fromJson(Map<String, dynamic> json) {
    return SupportHistoryModel(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      prevSubcategories: json['prevSubcategories'] != null
          ? List<Subcategory>.from(
          json['prevSubcategories'].map((x) => Subcategory.fromJson(x)))
          : null,
      subcategories: json['subcategories'] != null
          ? List<Subcategory>.from(
          json['subcategories'].map((x) => Subcategory.fromJson(x)))
          : null,
      prevBusinessName: json['prevBusinessName'],
      businessName: json['businessName'],
      prevCategory: json['prevCategory'] != null
          ? Category.fromJson(json['prevCategory'])
          : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      types: List<String>.from(json['types']),
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      prevEiin: json['prevEiin'],
      eiin: json['eiin'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user?.toJson(),
      'prevSubcategories': prevSubcategories?.map((x) => x.toJson()).toList(),
      'subcategories': subcategories?.map((x) => x.toJson()).toList(),
      'prevBusinessName': prevBusinessName,
      'businessName': businessName,
      'prevCategory': prevCategory?.toJson(),
      'category': category?.toJson(),
      'types': types,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class User {
  final String? id;
  final String? name;
  final String? eiin;
  final String? businessName;
  final String? profile;
  final String? category;

  User({
    this.id,
    this.name,
    this.eiin,
    this.businessName,
    this.profile,
    this.category,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      eiin: json['eiin'],
      businessName: json['businessName'],
      profile: json['profile'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'eiin': eiin,
      'businessName': businessName,
      'profile': profile,
      'category': category,
    };
  }
}

class Subcategory {
  final String? id;
  final String? title;

  Subcategory({
    this.id,
    this.title,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
    };
  }
}

class Category {
  final String id;
  final String title;

  Category({
    this.id = "",
    this.title = "",
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] != null &&  json['_id'] is String  ?  json['_id'] : "" ,
      title: json['title'] != null && json['title'] is String ? json['title'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
    };
  }
}