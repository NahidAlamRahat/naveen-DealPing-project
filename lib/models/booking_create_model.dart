class BookingCreateModel {
  String offerTitle;
  String offerDescription;
  String category;
  List<String> subCategories;
  String business;
  String request;

  BookingCreateModel({
    required this.offerTitle,
    required this.offerDescription,
    required this.category,
    required this.subCategories,
    required this.business,
    required this.request,
  });

  // JSON থেকে ডেটা নিতে চাইলে
  factory BookingCreateModel.fromJson(Map<String, dynamic> json) {
    return BookingCreateModel(
      offerTitle: json['offerTitle'],
      offerDescription: json['offerDescription'],
      category: json['category'],
      subCategories: List<String>.from(json['subCategories']),
      business: json['business'],
      request: json['request'],
    );
  }

  // API-তে পাঠানোর জন্য JSON তৈরি
  Map<String, dynamic> toJson() {
    return {
      "offerTitle": offerTitle,
      "offerDescription": offerDescription,
      "category": category,
      "subCategories": subCategories,
      "business": business,
      "request": request,
    };
  }
}
