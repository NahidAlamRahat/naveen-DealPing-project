class RequestModel {
  final String message;
  final double radius;
  final String category;
  final List<String> subCategories;
  final List<double> coordinates;

  RequestModel({
    required this.message,
    required this.radius,
    required this.category,
    required this.subCategories,
    required this.coordinates,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'radius': radius,
      'category': category,
      'subCategories': subCategories,
      'coordinates': coordinates,
    };
  }

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      message: json['message'],
      radius: (json['radius'] as num).toDouble(),
      category: json['category'],
      subCategories: List<String>.from(json['subCategories']),
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}
