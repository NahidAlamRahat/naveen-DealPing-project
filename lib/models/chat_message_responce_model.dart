class ChatMessageResponseModel {
  final String id;
  final String chatId;
  final Sender sender;
  final Receiver receiver;
  final String message;
  final String type;
  final List<String> images;
  final bool isRead;
  final String createdAt;
  final String updatedAt;

  ChatMessageResponseModel({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.type,
    required this.images,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponseModel(
      id: json['_id'],
      chatId: json['chat'],
      sender: Sender.fromJson(json['sender']),
      receiver: Receiver.fromJson(json['receiver']),
      message: json['message'],
      type: json['type'],
      images: List<String>.from(json['images']),
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Sender {
  final String id;
  final String name;
  final String profile;

  Sender({
    required this.id,
    required this.name,
    required this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      name: json['name'],
      profile: json['profile'],
    );
  }
}

class Receiver {
  final String id;
  final String name;
  final String address;
  final String profile;

  Receiver({
    required this.id,
    required this.name,
    required this.address,
    required this.profile,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      profile: json['profile'],
    );
  }
}
