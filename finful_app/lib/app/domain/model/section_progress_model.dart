import 'package:equatable/equatable.dart';
import 'package:finful_app/app/data/enum/section_progress.dart';

class SectionProgressItemModel extends Equatable {
  final SectionProgressStateType state;
  final SectionProgressStatusType status;

  const SectionProgressItemModel({
    required this.state,
    required this.status,
  });

  @override
  List<Object?> get props => [
    state,
    status,
  ];
}

class SectionProgressModel extends Equatable {
  final String? planId;
  final SectionProgressItemModel? quickCheck;
  final SectionProgressItemModel? familySupport;
  final SectionProgressItemModel? spending;
  final SectionProgressItemModel? assumptions;

  const SectionProgressModel({
    this.planId,
    this.quickCheck,
    this.familySupport,
    this.spending,
    this.assumptions,
  });

  @override
  List<Object?> get props => [
    planId,
    quickCheck,
    familySupport,
    spending,
    assumptions,
  ];
}