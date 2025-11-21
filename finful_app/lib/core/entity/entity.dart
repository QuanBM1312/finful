import 'package:equatable/equatable.dart';

export 'mapper.dart';

abstract class BaseEntity extends Equatable {
  Map<String, dynamic>? toJson();
}