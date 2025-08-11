class BookingStatsResponse {
  final List<BookingData> placed;
  final List<BookingData> converted;

  BookingStatsResponse({
    required this.placed,
    required this.converted,
  });

  factory BookingStatsResponse.fromJson(Map<String, dynamic> json) {
    return BookingStatsResponse(
      placed: (json['placed'] as List)
          .map((e) => BookingData.fromJson(e))
          .toList(),
      converted: (json['converted'] as List)
          .map((e) => BookingData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placed': placed.map((e) => e.toJson()).toList(),
      'converted': converted.map((e) => e.toJson()).toList(),
    };
  }
}

class BookingData {
  final int day;
  final double value;

  BookingData({
    required this.day,
    required this.value,
  });



  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      day: (json['day'] ?? 0).toInt(),
      value: (json['value'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'value': value,
    };
  }
}
