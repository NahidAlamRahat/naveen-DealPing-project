class BookingModel {
  final String id;
  final double rating;
  final String businessName;
  final String address;
  final double distance;
  final String userProfileImage;

  BookingModel({
    required this.id,
    required this.rating,
    required this.businessName,
    required this.address,
    required this.distance,
    required this.userProfileImage,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] ?? '',
      businessName: json['business']?['businessName'] ?? '',
      address: json['business']?['address'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      userProfileImage: json['user']?['profile'] ?? '',
      rating: (json['business']?['rating'] ?? 0).toDouble(),
    );
  }
}
