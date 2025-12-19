import 'package:finful_app/core/constant/model_constant.dart';

class BookingResponse {
  final String? id;
  final String? userId;
  final String? status;
  final String? notes;
  final String? adminNotes;
  final String? paymentStatus;
  final int? amount;

  BookingResponse({
    this.id,
    this.userId,
    this.status,
    this.notes,
    this.adminNotes,
    this.paymentStatus,
    this.amount,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      id: json['id'] ?? kString,
      userId: json['userId'] ?? kString,
      status: json['status'] ?? kString,
      notes: json['notes'] ?? kString,
      adminNotes: json['adminNotes'] ?? kString,
      paymentStatus: json['paymentStatus'] ?? kString,
      amount: json['amount'] ?? kInt,
    );
  }
}