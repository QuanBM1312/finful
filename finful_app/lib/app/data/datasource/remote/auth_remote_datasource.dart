import 'package:finful_app/app/data/model/response/logout_response.dart';
import 'package:finful_app/app/data/model/response/signin_response.dart';
import 'package:finful_app/app/data/model/response/signup_response.dart';
import 'package:finful_app/app/data/model/request/signin_request.dart';
import 'package:finful_app/app/data/model/request/signup_request.dart';

abstract interface class AuthRemoteDatasource {
  Future<SignInResponse> postSignIn(SignInRequest request);

  Future<SignUpResponse> postSignUp(SignUpRequest request);

  Future<LogoutResponse> postLogout();
}