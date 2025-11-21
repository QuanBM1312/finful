
import 'package:finful_app/core/entity/entity.dart';

class SignUpRequest extends BaseEntity {
  final String emailAddress;
  final String password;
  final String passwordVerification;
  final String firstName;
  final String lastName;

  SignUpRequest({
    required this.emailAddress,
    required this.password,
    required this.passwordVerification,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'emailAddress': emailAddress,
    'password': password,
    'passwordVerification': passwordVerification,
  };
}