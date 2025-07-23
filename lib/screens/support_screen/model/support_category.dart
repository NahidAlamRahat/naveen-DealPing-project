

class SupportCategory {
  final String id;
  final String title;
  final List<String> subCategories;

  SupportCategory({required this.id, required this.title, required this.subCategories});

  factory SupportCategory.fromJson(Map<String, dynamic> json) {
    return SupportCategory(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subCategories: List<String>.from(json['subCategories'] ?? []),
    );
  }
}



class SupportSubCategoryModel {
  final String id;
  final String title;

  SupportSubCategoryModel({
    required this.id,
    required this.title,
  });

  factory SupportSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SupportSubCategoryModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}