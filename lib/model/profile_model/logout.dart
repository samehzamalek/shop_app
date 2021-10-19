class LogOutModel {
  late  bool status;
  String? message;
  LogOutData? data;


  LogOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LogOutData.fromJson(json['data']) : null;
  }
}

class LogOutData {
  String? token;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  LogOutData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}