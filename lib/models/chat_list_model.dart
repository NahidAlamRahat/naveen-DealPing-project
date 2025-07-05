class ChatListModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<Chat> data;

  ChatListModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: List<Chat>.from(json['data'].map((x) => Chat.fromJson(x))),
    );
  }
}

class Chat {
  final String id;
  final String request;
  final String latestMessage;
  final bool isEnabled;
  final bool isMessageEnabled;
  final String status;
  final bool isDeleted;
  final String latestMessageTime;
  final String createdAt;
  final String updatedAt;
  final Participant participant;
  final int unreadMessageCount;

  Chat({
    required this.id,
    required this.request,
    required this.latestMessage,
    required this.isEnabled,
    required this.isMessageEnabled,
    required this.status,
    required this.isDeleted,
    required this.latestMessageTime,
    required this.createdAt,
    required this.updatedAt,
    required this.participant,
    required this.unreadMessageCount,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      request: json['request'],
      latestMessage: json['latestMessage'],
      isEnabled: json['isEnabled'],
      isMessageEnabled: json['isMessageEnabled'],
      status: json['status'],
      isDeleted: json['isDeleted'],
      latestMessageTime: json['latestMessageTime'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      participant: Participant.fromJson(json['participant']),
      unreadMessageCount: json['unreadMessageCount'],
    );
  }
}

class Participant {
  final String id;
  final String name;

  Participant({
    required this.id,
    required this.name,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'],
      name: json['name'],
    );
  }
}
