import 'package:equatable/equatable.dart';
import 'package:finful_app/app/data/model/user.dart';

abstract class SignInState extends Equatable {
  final String? email;

  const SignInState({
    this.email,
  });

  @override
  List<Object?> get props => [
    email,
  ];
}

class SignInInitial extends SignInState {}

class SignInInProgress extends SignInState {}

class SignInSuccess extends SignInState {
  const SignInSuccess({
    required String email,
    required User userInfo,
  }) : super(email: email);
}

class SignInWithoutUserInfoSuccess extends SignInState {
  SignInWithoutUserInfoSuccess(SignInState state) : super(
      email: state.email);
}

class SignInFailure extends SignInState {}