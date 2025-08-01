import 'package:deal_ping/utils/app_log/app_log.dart';

class AllOffers {
  final String id;
  final String business;
  final String title;
  final String description;
  final bool datumDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AllOffers({
    required this.id,
    required this.business,
    required this.title,
    required this.description,
    required this.datumDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
  AllOffers copyWith({
    String? id,
    String? business,
    String? title,
    String? description,
    bool? datumDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return AllOffers(
      id: id ?? this.id,
      business: business ?? this.business,
      title: title ?? this.title,
      description: description ?? this.description,
      datumDefault: datumDefault ?? this.datumDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory AllOffers.fromJson(Map<String, dynamic> json) {
    // appLog("====================> ddddddddd ${json['default'] }");
    return AllOffers(
      id: json['_id'] ?? '',
      business: json['business'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      datumDefault: json['default'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'business': business,
      'title': title,
      'description': description,
      'default': datumDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }


}
