enum SectionType {
  onboarding,
  familySupport,
  spending,
  assumptions,
  undefined,
}

extension SectionTypeExt on SectionType {
  static SectionType fromValue(String? value) {
    switch (value) {
      case 'quickCheck':
        return SectionType.onboarding;
      case 'familySupport':
        return SectionType.familySupport;
      case 'spending':
        return SectionType.spending;
      case 'assumptions':
        return SectionType.assumptions;
      default:
        return SectionType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionType.onboarding:
        return 'quickCheck';
      case SectionType.familySupport:
        return 'familySupport';
      case SectionType.spending:
        return 'spending';
      case SectionType.assumptions:
        return 'assumptions';
      default:
        return 'undefined';
    }
  }
}

enum SectionStepType { question, education, Final, undefined }

extension SectionStepTypeExt on SectionStepType {
  static SectionStepType fromValue(String? value) {
    switch (value) {
      case 'EDUCATION':
        return SectionStepType.education;
      case 'QUESTION':
        return SectionStepType.question;
      case 'FINAL':
        return SectionStepType.Final;
      default:
        return SectionStepType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionStepType.education:
        return 'EDUCATION';
      case SectionStepType.question:
        return 'QUESTION';
      case SectionStepType.Final:
        return 'FINAL';
      default:
        return 'undefined';
    }
  }
}

enum SectionQAStatusType { activate, complete, undefined }

extension SectionQAStatusTypeExt on SectionQAStatusType {
  static SectionQAStatusType fromValue(String? value) {
    switch (value) {
      case 'activate':
        return SectionQAStatusType.activate;
      case 'completed':
        return SectionQAStatusType.complete;
      default:
        return SectionQAStatusType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionQAStatusType.activate:
        return 'activate';
      case SectionQAStatusType.complete:
        return 'completed';
      default:
        return 'undefined';
    }
  }
}

enum SectionQuestionType {
  options,
  number,
  slider,
  radio,
  undefined,
}

extension SectionQuestionTypeExt on SectionQuestionType {
  static SectionQuestionType fromValue(String? value) {
    switch (value) {
      case 'options':
        return SectionQuestionType.options;
      case 'number':
        return SectionQuestionType.number;
      case 'slider':
        return SectionQuestionType.slider;
      case 'radio':
        return SectionQuestionType.radio;
      default:
        return SectionQuestionType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionQuestionType.options:
        return 'options';
      case SectionQuestionType.number:
        return 'number';
      case SectionQuestionType.slider:
        return 'slider';
      case SectionQuestionType.radio:
        return 'radio';
      default:
        return 'undefined';
    }
  }
}

enum SectionPayloadChartDataKeyType {
  pctSalaryGrowth,
  pctInvestmentReturn,
  undefined,
}

extension SectionPayloadChartDataKeyTypeExt on SectionPayloadChartDataKeyType {
  static SectionPayloadChartDataKeyType fromValue(String? value) {
    switch (value) {
      case 'pctSalaryGrowth':
        return SectionPayloadChartDataKeyType.pctSalaryGrowth;
      case 'pctInvestmentReturn':
        return SectionPayloadChartDataKeyType.pctInvestmentReturn;
      default:
        return SectionPayloadChartDataKeyType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionPayloadChartDataKeyType.pctSalaryGrowth:
        return 'pctSalaryGrowth';
      case SectionPayloadChartDataKeyType.pctInvestmentReturn:
        return 'pctInvestmentReturn';
      default:
        return 'undefined';
    }
  }
}

