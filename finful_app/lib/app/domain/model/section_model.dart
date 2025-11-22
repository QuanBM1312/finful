import 'package:equatable/equatable.dart';
import 'package:finful_app/app/data/model/response/section_response.dart';

class SectionAnswerModel extends Equatable {
  final String questionKey;
  final dynamic answer;

  const SectionAnswerModel({
    required this.questionKey,
    required this.answer
  });

  @override
  List<Object?> get props => [
    questionKey,
    answer,
  ];
}

class SectionModel extends Equatable {
  final SectionResponse section;
  final SectionAnswerModel? answerFilled;

  const SectionModel({
    required this.section,
    this.answerFilled,
  });

  SectionModel copyWith({
    final SectionAnswerModel? answerFilled,
  }) {
    return SectionModel(
      section: section,
      answerFilled: answerFilled ?? this.answerFilled,
    );
  }

  @override
  List<Object?> get props => [
    section,
    answerFilled,
  ];

}