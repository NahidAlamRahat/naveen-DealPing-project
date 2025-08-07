class SupportRequestModel {
  final String? category;  // This should be the category ID, not the title
  final List<String>? subcategories;  // This should be a list of subcategory IDs, not titles
  final String? businessName;
  final String? eiin;


  SupportRequestModel({
    this.category,
    this.subcategories,
    this.businessName,
    this.eiin,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (category != null) data['category'] = category;  // category ID
    if (subcategories != null && subcategories!.isNotEmpty) {
      data['subcategories'] = subcategories;  // list of subcategory IDs
    }
    if (businessName != null) data['businessName'] = businessName;
    if (eiin != null) data['eiin'] = eiin;

    return data;
  }
}
