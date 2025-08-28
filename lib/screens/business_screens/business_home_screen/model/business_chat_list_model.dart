
class BusinessesChatListModel {
  String id;
  List<String> requests;
  String latestMessage;
  String latestMessageTime;
  bool isEnabled;
  bool isMessageEnabled;
  double distance;
  bool isDeleted;
  int v;
  String createdAt;
  String updatedAt;
  Participant participant;
  int unreadMessageCount;
  LatestStatusMessage? latestStatusMessage;
  int statusMessageCount;

  BusinessesChatListModel({
    required this.id,
    required this.requests,
    required this.latestMessage,
    required this.latestMessageTime,
    required this.isEnabled,
    required this.isMessageEnabled,
    required this.distance,
    required this.isDeleted,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.participant,
    required this.unreadMessageCount,
    this.latestStatusMessage,
    required this.statusMessageCount,
  });

  factory BusinessesChatListModel.fromJson(Map<String, dynamic> json) {
    return BusinessesChatListModel(
      id: json['_id'] ?? '',
      requests: json['requests'] != null
          ? List<String>.from(json['requests'])
          : [],
      latestMessage: json['latestMessage'] ?? '',
      latestMessageTime: json['latestMessageTime'] ?? '',
      isEnabled: json['isEnabled'] ?? false,
      isMessageEnabled: json['isMessageEnabled'] ?? false,
      distance: (json['distance'] != null)
          ? (json['distance'] as num).toDouble()
          : 0.0,
      isDeleted: json['isDeleted'] ?? false,
      v: json['__v'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      participant: json['participant'] != null
          ? Participant.fromJson(json['participant'])
          : Participant(id: '', name: 'Unknown', profile: ''),
      unreadMessageCount: json['unreadMessageCount'] ?? 0,
      latestStatusMessage: json['latestStatusMessage'] != null
          ? LatestStatusMessage.fromJson(json['latestStatusMessage'])
          : null,
      statusMessageCount: json['statusMessageCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requests': requests,
      'latestMessage': latestMessage,
      'latestMessageTime': latestMessageTime,
      'isEnabled': isEnabled,
      'isMessageEnabled': isMessageEnabled,
      'distance': distance,
      'isDeleted': isDeleted,
      '__v': v,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'participant': participant.toJson(),
      'unreadMessageCount': unreadMessageCount,
      'latestStatusMessage': latestStatusMessage?.toJson(),
      'statusMessageCount': statusMessageCount,
    };
  }
}

class Participant {
  String id;
  String name;
  String profile;

  Participant({
    required this.id,
    required this.name,
    required this.profile,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      profile: json['profile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'profile': profile,
    };
  }
}

class LatestStatusMessage {
  String id;
  String request;
  String message;
  String type;
  String createdAt;

  LatestStatusMessage({
    required this.id,
    required this.request,
    required this.message,
    required this.type,
    required this.createdAt,
  });

  factory LatestStatusMessage.fromJson(Map<String, dynamic> json) {
    return LatestStatusMessage(
      id: json['_id'] ?? '',
      request: json['request'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'text',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'request': request,
      'message': message,
      'type': type,
      'createdAt': createdAt,
    };
  }
}

