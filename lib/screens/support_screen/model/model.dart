class SubCategory {
  String id;
  String title;

  SubCategory({required this.id, required this.title});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'] ?? '', // Ensure the value is non-null
      title: json['title'] ?? '', // Ensure the value is non-null
    );
  }

  @override
  String toString() {
    return 'SubCategory(id: $id, title: $title)';
  }
}



class SupportCategory {
  String id;
  String title;
  List<SubCategory> subCategories;

  SupportCategory({required this.id, required this.title, required this.subCategories});

  factory SupportCategory.fromJson(Map<String, dynamic> json) {
    var list = json['subCategories'] as List?;
    List<SubCategory> subCategoryList = list != null
        ? list.map((i) => SubCategory.fromJson(i)).toList()
        : []; // If null, return empty list

    return SupportCategory(
      id: json['_id'] ?? '', // Ensure the value is non-null
      title: json['title'] ?? '', // Ensure the value is non-null
      subCategories: subCategoryList,
    );
  }

  @override
  String toString() {
    return 'SupportCategory(id: $id, title: $title, subCategories: $subCategories)';
  }
}

