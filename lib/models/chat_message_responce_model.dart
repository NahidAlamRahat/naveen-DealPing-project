class ChatMessageResponseModel {
  String? id;
  String? chatId;
  Sender? sender;
  Receiver? receiver;
  String? message;
  String? type;
  List<String>? images;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  int? v;


  // ✅ New fields for business offers
  String? offerTitle;
  String? offerDescription;
  String? offerImageUrl;
  double? distance;


  ChatMessageResponseModel({
    this.id,
    this.chatId,
    this.sender,
    this.receiver,
    this.message,
    this.type,
    this.images,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,

    this.offerTitle,
    this.offerDescription,
    this.offerImageUrl,
    this.distance,


  });

  // Factory method for creating an instance from JSON
  factory ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponseModel(
      id: json['_id'],
      // chatId: json['chat'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null,
      message: json['message'],
      type: json['type'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],


      // ✅ Custom offer fields from JSON
      offerTitle: json['offerTitle'],
      offerDescription: json['offerDescription'],
      offerImageUrl: json['offerImageUrl'],
      distance: json['distance'] != null ? (json['distance'] as num).toDouble() : null,

    );
  }

  // fromMap method to handle a Map<String, dynamic> (generic use case)
  factory ChatMessageResponseModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageResponseModel(
      id: map['_id'],
      // chatId: map['chat'],
      sender: map['sender'] != null ? Sender.fromMap(map['sender']) : null,
      receiver: map['receiver'] != null ? Receiver.fromMap(map['receiver']) : null,
      message: map['message'],
      type: map['type'],
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      isRead: map['isRead'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      v: map['__v'],


      offerTitle: map['offerTitle'],
      offerDescription: map['offerDescription'],
      offerImageUrl: map['offerImageUrl'],
      distance: map['distance'] != null ? (map['distance'] as num).toDouble() : null,

    );
  }

  // Method to convert the object to JSON for API or serialization
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chat': chatId,
      'sender': sender?.toJson(),
      'receiver': receiver?.toJson(),
      'message': message,
      'type': type,
      'images': images,
      'isRead': isRead,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,

      // ✅ Include these in serialization too
      'offerTitle': offerTitle,
      'offerDescription': offerDescription,
      'offerImageUrl': offerImageUrl,
      'distance': distance,

    };
  }
}

class Sender {
  String? id;
  String? name;
  String? address;
  String? profile;
  double? rating;

  Sender({
    this.id,
    this.name,
    this.address,
    this.profile,
    this.rating,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      profile: json['profile'],
      rating: (json['rating'] != null) ? json['rating'].toDouble() : null,
    );
  }

  factory Sender.fromMap(Map<String, dynamic> map) {
    return Sender(
      id: map['_id'],
      name: map['name'],
      address: map['address'],
      profile: map['profile'],
      rating: (map['rating'] != null) ? map['rating'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      'profile': profile,
      'rating': rating,
    };
  }
}

class Receiver {
  String? id;
  String? name;
  String? profile;

  Receiver({
    this.id,
    this.name,
    this.profile,
  });

  // Factory method for creating an instance from JSON
  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json['_id'],
      name: json['name'],
      profile: json['profile'],
    );
  }

  // fromMap method to handle a Map<String, dynamic> (generic use case)
  factory Receiver.fromMap(Map<String, dynamic> map) {
    return Receiver(
      id: map['_id'],
      name: map['name'],
      profile: map['profile'],
    );
  }

  // Method to convert the object to JSON for API or serialization
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'profile': profile,
    };
  }
}
