import 'package:finful_app/core/constant/model_constant.dart';
import 'package:finful_app/core/entity/entity.dart';

class User extends BaseEntity {
  final String? userId;
  final String? email;
  final String? firstName;
  final String? lastName;

  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? kString,
      email: json['email'] ?? kString,
      firstName: json['firstName'] ?? kString,
      lastName: json['lastName'] ?? kString,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    email,
    firstName,
    lastName
  ];

  @override
  Map<String, dynamic>? toJson() => {
    'userId': userId,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
  };
}
