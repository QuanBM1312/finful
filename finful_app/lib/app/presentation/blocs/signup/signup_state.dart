
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  final String? email;

  const SignUpState({
    this.email,
  });

  @override
  List<Object?> get props => [
    email,
  ];
}

class SignUpInitial extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess({
    required String email,
  }) : super(email: email);
}

class SignUpFailure extends SignUpState {}