import 'package:finful_app/core/constant/model_constant.dart';

class ChatResponse {
  final String? id;
  final String? userId;
  final String? status;
  final String? notes;

  ChatResponse({
    this.id,
    this.userId,
    this.status,
    this.notes,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      id: json['id'] ?? kString,
      userId: json['userId'] ?? kString,
      status: json['status'] ?? kString,
      notes: json['notes'] ?? kString,
    );
  }
}