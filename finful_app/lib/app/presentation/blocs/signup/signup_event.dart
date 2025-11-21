
abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  SignUpSubmitted({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
