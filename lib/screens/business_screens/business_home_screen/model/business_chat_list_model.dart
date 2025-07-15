class BusinessesChatListModel {
  final String id;
  final String latestMessage;
  final String name;
  final String profileImage;
  final String createdAt;
  final int unreadMessageCount;




  BusinessesChatListModel({
    required this.unreadMessageCount,
    required this.id,
    required this.name,
    required this.profileImage,
   required this. latestMessage,
    required this.createdAt
  });

  factory BusinessesChatListModel.fromJson(Map<String, dynamic> json) {
    return BusinessesChatListModel(
      id: json['_id'] ?? '',
      name: json['participant']?['name'] ?? '',
      latestMessage: json['data']?['latestMessage'] ?? '',
      profileImage: json['participant']?['profile'] ?? '',
      createdAt: json['createdAt'] ?? '',
      unreadMessageCount: json['unreadMessageCount'] ?? 0,

    );
  }
}
