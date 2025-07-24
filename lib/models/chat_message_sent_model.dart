class ChatMessageModel {
  final String chatId;
  final String message;
  final String type;
  final List<String> images;
  final String senderId;
  final String receiverId;

  ChatMessageModel({
    required this.chatId,
    required this.message,
    required this.type,
    required this.images,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toJson() {
    return {
      "chat": chatId,
      "message": message,
      "type": type,
      "images": images,
      "sender": senderId,
      "receiver": receiverId,
    };
  }
}
