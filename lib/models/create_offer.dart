class CreateOfferRequestModel {
  final String? offerTitle;
  final String? offerDescription;
  final String? category;
  final List<String>? subCategories;
  final String? business;
  final String? request;

  CreateOfferRequestModel({
    this.offerTitle,
    this.offerDescription,
    this.category,
    this.subCategories,
    this.business,
    this.request,
  });

  Map<String, dynamic> toJson() {
    return {
      'offerTitle': offerTitle,
      'offerDescription': offerDescription,
      'category': category,
      'subCategories': subCategories,
      'business': business,
      'request': request,
    };
  }
}
