import 'package:finful_app/core/constant/model_constant.dart';

import '../entity/entity.dart';

enum ApiHeaderType { normal, withToken, withoutToken }

class Authorization extends BaseEntity {
  final String? accessToken;
  final String? refreshToken;
  final String? userId;

  Authorization({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      accessToken: json['access_token'] ?? kString,
      refreshToken: json['refresh_token'] ?? kString,
      userId: json['userId'] ?? kString,
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    userId
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'userId': userId
    };
  }
}

class HeaderConfig {
  final String encodedCredentials;
  final String refreshTokenPath;
  HeaderConfig({
    required this.encodedCredentials,
    required this.refreshTokenPath,
  });
}
