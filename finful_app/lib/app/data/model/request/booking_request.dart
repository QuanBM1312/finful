import 'package:finful_app/core/entity/entity.dart';

class BookingRequest extends BaseEntity {
  final String phoneNumber;
  final String name;

  BookingRequest({
    required this.phoneNumber,
    required this.name,
  });

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() => {
    'name': name,
    'phoneNumber': phoneNumber,
  };
}