class NotificationModel {
  final String id;
  final String businessName;
  final bool isRead;
  final String body;
  final String userProfileImage;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.businessName,
    required this.isRead,
    required this.body,
    required this.userProfileImage,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['sender']?['_id'] ?? '',
      businessName: json['sender']?['name'] ?? '',
      userProfileImage: json['sender']?['profile'] ?? '',
      createdAt: json['createdAt'] ?? '',
      isRead: json['isRead'] ?? false, // use `false` instead of '' for bool
      body: json['body'] ?? '',
    );
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id,'
        ' businessName: $businessName, '
        'isRead: $isRead, '
        'body: $body,'
        ' userProfileImage: $userProfileImage, '
        'createdAt: $createdAt)';
  }
}
