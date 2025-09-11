class BusinessesChatListModel {
  String? id;
  List<String>? requests;
  String? latestMessage;
  String? latestMessageTime;
  bool? isEnabled;
  bool? isMessageEnabled;
  double? distance;
  bool? isDeleted;
  int? v;
  String? createdAt;
  String? updatedAt;
  Participant? participant;
  int? unreadMessageCount;
  LatestStatusMessage? latestStatusMessage;
  int? statusMessageCount;

  BusinessesChatListModel({
    this.id,
    this.requests,
    this.latestMessage,
    this.latestMessageTime,
    this.isEnabled,
    this.isMessageEnabled,
    this.distance,
    this.isDeleted,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.participant,
    this.unreadMessageCount,
    this.latestStatusMessage,
    this.statusMessageCount,
  });

  factory BusinessesChatListModel.fromJson(Map<String, dynamic> json) {
    return BusinessesChatListModel(
      id: json['_id'],
      requests: json['requests'] != null
          ? List<String>.from(json['requests'])
          : null,
      latestMessage: json['latestMessage'],
      latestMessageTime: json['latestMessageTime'],
      isEnabled: json['isEnabled'],
      isMessageEnabled: json['isMessageEnabled'],
      distance: (json['distance'] != null)
          ? (json['distance'] as num).toDouble()
          : null,
      isDeleted: json['isDeleted'],
      v: json['__v'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      participant: json['participant'] != null
          ? Participant.fromJson(json['participant'])
          : null,
      unreadMessageCount: json['unreadMessageCount'],
      latestStatusMessage: json['latestStatusMessage'] != null
          ? LatestStatusMessage.fromJson(json['latestStatusMessage'])
          : null,
      statusMessageCount: json['statusMessageCount'],
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
      'participant': participant?.toJson(),
      'unreadMessageCount': unreadMessageCount,
      'latestStatusMessage': latestStatusMessage?.toJson(),
      'statusMessageCount': statusMessageCount,
    };
  }
}

class Participant {
  String? id;
  String? name;
  String? profile;

  Participant({
    this.id,
    this.name,
    this.profile,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'],
      name: json['name'],
      profile: json['profile'],
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
  String? id;
  String? request;
  String? message;
  String? type;
  String? createdAt;

  LatestStatusMessage({
    this.id,
    this.request,
    this.message,
    this.type,
    this.createdAt,
  });

  factory LatestStatusMessage.fromJson(Map<String, dynamic> json) {
    return LatestStatusMessage(
      id: json['_id'],
      request: json['request'],
      message: json['message'],
      type: json['type'],
      createdAt: json['createdAt'],
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
