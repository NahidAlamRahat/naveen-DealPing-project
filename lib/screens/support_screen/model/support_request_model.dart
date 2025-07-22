class SupportRequest {
  final String type;
  final String? categoryId;
  final List<String>? subcategoryIds;
  final String? businessName;
  final String? eiinNumber;
  final String? description;

  SupportRequest({
    required this.type,
    this.categoryId,
    this.subcategoryIds,
    this.businessName,
    this.eiinNumber,
    this.description,
  });

  // Convert to JSON (for API requests)
  Map<String, dynamic> toJson() => {
    'type': type,
    if (categoryId != null) 'category': categoryId,
    if (subcategoryIds != null && subcategoryIds!.isNotEmpty)
      'subcategories': subcategoryIds,
    if (businessName != null) 'businessName': businessName,
    if (eiinNumber != null) 'eiin': eiinNumber,
    if (description != null) 'description': description,
  };

  // Helper method to validate the request
  bool get isValid {
    switch (type) {
      case 'Changed Category Name':
        return categoryId != null && (subcategoryIds?.isNotEmpty ?? false);
      case 'Business Name':
        return businessName != null && businessName!.isNotEmpty;
      case 'Eiin Number':
        return eiinNumber != null && eiinNumber!.isNotEmpty;
      default: // 'Other' or unspecified types
        return description != null && description!.isNotEmpty;
    }
  }
}
