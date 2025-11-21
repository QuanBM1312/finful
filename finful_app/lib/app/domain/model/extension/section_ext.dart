
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/domain/model/section_model.dart';

extension SectionAnswerModelListExt on List<SectionAnswerModel> {
  List<SectionAnswerRequest> toRequest() {
    if (isEmpty) return <SectionAnswerRequest>[];

    final data = map((e) => SectionAnswerRequest(
        question: e.questionKey,
        answer: e.answer
    )).toList();
    return data;
  }
}

extension SectionModelListExt on List<SectionModel> {
  List<SectionAnswerModel> get toValidAnswersFilled {
    final validData = where((e) => e.answerFilled != null).toList();
    final answersFilled = validData.map((e) => e.answerFilled!).toList();
    return answersFilled;
  }
}