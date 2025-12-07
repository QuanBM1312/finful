import 'package:finful_app/app/data/datasource/remote/auth_remote_datasource.dart';
import 'package:finful_app/app/data/model/response/logout_response.dart';
import 'package:finful_app/app/data/model/response/signin_response.dart';
import 'package:finful_app/app/data/model/response/signup_response.dart';
import 'package:finful_app/app/data/model/request/signin_request.dart';
import 'package:finful_app/app/data/model/request/signup_request.dart';
import 'package:finful_app/core/datasource/base_remote.dart';
import 'package:finful_app/core/datasource/config.dart';

class AuthRemoteDatasourceImpl extends BaseRemote implements AuthRemoteDatasource {
  late final String _host;

  AuthRemoteDatasourceImpl({
    required String host,
    required super.config,
    super.getAuthorization,
  })  : _host = host;

  @override
  Future<LogoutResponse> postLogout() async {
    final url = '$_host/auth/logout';
    final json =
        await post(url, ApiHeaderType.withToken);
    return LogoutResponse.fromJson(json);
  }

  @override
  Future<SignInResponse> postSignIn(SignInRequest request) async {
    final url = '$_host/auth/sign-in';
    final json =
        await post(url, ApiHeaderType.withoutToken, data: request.toJson());
    return SignInResponse.fromJson(json);
  }

  @override
  Future<SignUpResponse> postSignUp(SignUpRequest request) async {
    final url = '$_host/auth/sign-up';
    final json =
        await post(url, ApiHeaderType.withoutToken, data: request.toJson());
    return SignUpResponse.fromJson(json);
  }
  
}