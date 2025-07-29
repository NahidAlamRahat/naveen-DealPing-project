class BookingModel {
  final String id;
  final String offerTitle;
  final String offerDescription;
  final String categoryTitle;
  final List<String> subCategories;
  final String userName;
  final String userProfileImage;
  final String businessName;
  final String address;
  final double rating;
  final double distance;
  final String bookingCode;
  final String createdAt;

  BookingModel({
    required this.id,
    required this.offerTitle,
    required this.offerDescription,
    required this.categoryTitle,
    required this.subCategories,
    required this.userName,
    required this.userProfileImage,
    required this.businessName,
    required this.address,
    required this.rating,
    required this.distance,
    required this.bookingCode,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] ?? '',
      offerTitle: json['offerTitle'] ?? '',
      offerDescription: json['offerDescription'] ?? '',
      categoryTitle: json['category']?['title'] ?? '',
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e['title']?.toString() ?? '')
          .toList() ??
          [],
      userName: json['user']?['name'] ?? '',
      userProfileImage: json['user']?['profile'] ?? '',
      businessName: json['business']?['businessName'] ?? '',
      address: json['business']?['address'] ?? '',
      rating: (json['business']?['rating'] ?? 0).toDouble(),
      distance: (json['distance'] ?? 0).toDouble(),
      bookingCode: json['code'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
