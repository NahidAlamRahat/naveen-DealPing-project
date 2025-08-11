class UserGrowthResponse {
  final List<UserGrowthData> bookings;
  final List<UserGrowthData> requests;

  UserGrowthResponse({
    required this.bookings,
    required this.requests,
  });

  factory UserGrowthResponse.fromJson(Map<String, dynamic> json) {
    return UserGrowthResponse(
      bookings: (json['bookings'] as List? ?? [])
          .map((e) => UserGrowthData.fromJson(e))
          .toList(),
      requests: (json['requests'] as List? ?? [])
          .map((e) => UserGrowthData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookings': bookings.map((e) => e.toJson()).toList(),
      'requests': requests.map((e) => e.toJson()).toList(),
    };
  }
}

class UserGrowthData {
  final int day;
  final double value;

  UserGrowthData({
    required this.day,
    required this.value,
  });

  factory UserGrowthData.fromJson(Map<String, dynamic> json) {
    return UserGrowthData(
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
