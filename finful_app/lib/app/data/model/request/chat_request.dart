import 'package:finful_app/core/entity/entity.dart';

class ChatRequest extends BaseEntity {
  final String phoneNumber;

  ChatRequest({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() => {
    'phoneNumber': phoneNumber,
  };
}