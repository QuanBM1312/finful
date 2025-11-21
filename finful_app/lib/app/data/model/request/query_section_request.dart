
import 'package:finful_app/core/entity/entity.dart';

class SectionAnswerRequest {
  final String question;
  final dynamic answer;

  SectionAnswerRequest({
    required this.question,
    required this.answer,
  });
}

extension SectionAnswerRequestListExt on List<SectionAnswerRequest> {
  Map<String, dynamic> toAnswersMap() {
    return isEmpty
        ? <String, dynamic>{}
        : Map.fromEntries(map((e) => MapEntry(e.question, e.answer)));
  }
}

class SectionRequest extends BaseEntity {
  final String currentSection;
  final List<SectionAnswerRequest> answers;

  SectionRequest({
    required this.currentSection,
    required this.answers,
  });

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic>? toJson() {
    final answersMap = answers.toAnswersMap();
    return {
      'currentSection': currentSection,
      'answers': answersMap,
    };
  }
}