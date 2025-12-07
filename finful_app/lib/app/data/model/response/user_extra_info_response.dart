import 'package:finful_app/core/constant/model_constant.dart';

class UserExtInfoUserResponse {
  final String? id;
  final String? imageUrl;
  final String? email;
  final String? firstName;
  final String? lastName;

  UserExtInfoUserResponse({
    this.id,
    this.imageUrl,
    this.email,
    this.firstName,
    this.lastName
  });

  factory UserExtInfoUserResponse.fromJson(Map<String, dynamic> json) {
    return UserExtInfoUserResponse(
      id: json['id'] ?? kString,
      imageUrl: json['imageUrl'] ?? kString,
      email: json['email'] ?? kString,
      firstName: json['firstName'] ?? kString,
      lastName: json['lastName'] ?? kString,
    );
  }
}

class UserExtInfoPlanResponse {
  final int? time;
  final String? type;
  final String? location;

  UserExtInfoPlanResponse({
    this.time,
    this.type,
    this.location,
  });

  factory UserExtInfoPlanResponse.fromJson(Map<String, dynamic> json) {
    return UserExtInfoPlanResponse(
      time: json['time'] ?? kInt,
      type: json['type'] ?? kString,
      location: json['location'] ?? kString,
    );
  }
}

class UserExtInfoResponse {
  final UserExtInfoUserResponse? user;
  final UserExtInfoPlanResponse? plan;
  final String? amountSaved;
  final String? housePrice;
  final String? loanAmount;

  UserExtInfoResponse({
    this.user,
    this.plan,
    this.amountSaved,
    this.housePrice,
    this.loanAmount
  });

  factory UserExtInfoResponse.fromJson(Map<String, dynamic> json) {
    final user = json['user'] != null
        ? UserExtInfoUserResponse.fromJson(json['user']) : null;
    final plan = json['plan'] != null
        ? UserExtInfoPlanResponse.fromJson(json['plan']) : null;

    return UserExtInfoResponse(
      user: user,
      plan: plan,
      amountSaved: json['amountSaved'] ?? kString,
      housePrice: json['housePrice'] ?? kString,
      loanAmount: json['loanAmount'] ?? kString,
    );
  }
}