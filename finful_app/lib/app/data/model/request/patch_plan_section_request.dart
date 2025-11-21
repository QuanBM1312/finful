import 'package:finful_app/core/entity/entity.dart';

import 'query_section_request.dart';

class PatchPlanSectionRequest extends BaseEntity {
  final String currentSection;
  final List<SectionAnswerRequest> answers;

  PatchPlanSectionRequest({
    required this.currentSection,
    required this.answers,
  });

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() {
    final answersMap = answers.toAnswersMap();
    return {
      'section': currentSection,
      'data': answersMap,
    };
  }
}