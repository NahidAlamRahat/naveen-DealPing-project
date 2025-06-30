class TermsAndConditions {
  int? statusCode;
  bool? success;
  String? message;
  TermsData? data;

  TermsAndConditions({this.statusCode, this.success, this.message, this.data});

  TermsAndConditions.fromJson(Map json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? TermsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TermsData {
  String? sId;
  String? content;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TermsData(
      {this.sId,
      this.content,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TermsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
