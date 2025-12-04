import 'package:equatable/equatable.dart';

class EducationModel extends Equatable {
  final String? title;
  final String? message;
  final String? url;
  final int order;

  const EducationModel({
    this.title,
    this.message,
    this.url,
    required this.order,
  });

  @override
  List<Object?> get props => [
    title,
    message,
    url,
    order,
  ];
}