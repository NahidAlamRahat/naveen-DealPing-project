// offer_model.dart

class BookingCreateModel {
  final String offerTitle;
  final String offerDescription;
  final String business;
  final String request;
  final String chat;

  BookingCreateModel({
    required this.offerTitle,
    required this.offerDescription,
    required this.business,
    required this.request,
    required this.chat,
  });

  factory BookingCreateModel.fromJson(Map<String, dynamic> json) {
    return BookingCreateModel(
      offerTitle: json['offerTitle'] as String? ?? '',
      offerDescription: json['offerDescription'] as String? ?? '',
      business: json['business'] as String? ?? '',
      request: json['request'] as String? ?? '',
      chat: json['chat'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'offerTitle': offerTitle,
    'offerDescription': offerDescription,
    'business': business,
    'request': request,
    'chat': chat,
  };
}
