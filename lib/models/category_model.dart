
class Category {
  final String? id;
  final String? title;
  final String? icon;
  final List<SubCategory>? subCategories;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  Category({
    this.id,
    this.title,
    this.icon,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] != null && json['_id'] is String ? json['_id'] : "",
      title: json['title'],
      icon: json['icon'],
      subCategories: (json['subCategories'] as List)
          .map((item) => SubCategory.fromJson(item))
          .toList(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'icon': icon,
      'subCategories': subCategories?.map((item) => item.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
    };
  }

  Category copyWith({
    String? id,
    String? title,
    String? icon,
    List<SubCategory>? subCategories,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      subCategories: subCategories ?? this.subCategories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }
}

class SubCategory {
  final String? id;
  final String? title;

  SubCategory({
    this.id,
    this.title,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
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

  SubCategory copyWith({
    String? id,
    String? title,
  }) {
    return SubCategory(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}