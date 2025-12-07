import 'package:finful_app/core/constant/model_constant.dart';
import 'package:finful_app/core/entity/entity.dart';

class User extends BaseEntity {
  final String? userId;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;

  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? kString,
      email: json['email'] ?? kString,
      firstName: json['firstName'] ?? kString,
      lastName: json['lastName'] ?? kString,
      imageUrl: json['imageUrl'] ?? kString,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    email,
    firstName,
    lastName,
    imageUrl,
  ];

  @override
  Map<String, dynamic>? toJson() => {
    'userId': userId,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'imageUrl': imageUrl,
  };
}
