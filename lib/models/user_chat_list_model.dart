class ChatModel {
  final String chatId; //main
  final String requestId;
  late final String latestMessage;
  final String latestMessageTime;
  // final String createdAt;
  // final String updatedAt;
  final int unreadMessageCount;
  final String participantId;
  final String participantName;
  final String participantBusinessName;
  final String participantProfile;

  ChatModel({
    required this.chatId,
    required this.requestId,
    required this.latestMessage,
    required this.latestMessageTime,
    // required this.createdAt,
    // required this.updatedAt,
    required this.unreadMessageCount,
    required this.participantId,
    required this.participantName,
    required this.participantBusinessName,
    required this.participantProfile,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final participant = json['participant'] ?? {};

    return ChatModel(
      chatId: json['_id'] ?? '',
      requestId: json['request'] ?? '',
      latestMessage: json['latestMessage'] ?? '',
      latestMessageTime: json['latestMessageTime'] ?? '',
      // createdAt: json['createdAt'] ?? '',
      // updatedAt: json['updatedAt'] ?? '',
      unreadMessageCount: json['unreadMessageCount'] ?? 0,
      participantId: participant['_id'] ?? '',
      participantName: participant['name'] ?? '',
      participantBusinessName: participant['businessName'] ?? '',
      participantProfile: participant['profile'] ?? '',
    );
  }
}
