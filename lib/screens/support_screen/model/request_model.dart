class SupportRequestModel {
  final String? category;
  final List<String>? subcategories;
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

    if (category != null) data['category'] = category;
    if (subcategories != null && subcategories!.isNotEmpty) {
      data['subcategories'] = subcategories;
    }
    if (businessName != null) data['businessName'] = businessName;
    if (eiin != null) data['eiin'] = eiin;

    return data;
  }
}