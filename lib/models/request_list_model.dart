class RequestModel {
  final String requestId;
  final String userId;
  final String category;
  final List<String> subCategories;
  final String message;
  final double radius;
  final List<double> coordinates;
  final String createdAt;
  final String updatedAt;

  RequestModel({
    required this.requestId,
    required this.userId,
    required this.category,
    required this.subCategories,
    required this.message,
    required this.radius,
    required this.coordinates,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestId: json['_id'],
      userId: json['user'],
      category: json['category'],
      subCategories: List<String>.from(json['subCategories']),
      message: json['message'],
      radius: (json['radius'] as num).toDouble(),
      coordinates:
          List<double>.from(json['coordinates'].map((x) => x.toDouble())),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
