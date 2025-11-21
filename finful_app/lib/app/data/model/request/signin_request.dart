
import 'package:finful_app/core/entity/entity.dart';

class SignInRequest extends BaseEntity {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() => {
    'email': email,
    'password': password,
  };
}