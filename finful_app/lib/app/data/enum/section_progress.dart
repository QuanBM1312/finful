enum SectionProgressStateType {
  notStarted,
  inProgress,
  completed,
  undefined,
}

extension SectionProgressStateTypeExt on SectionProgressStateType {
  static SectionProgressStateType fromValue(String? value) {
    switch (value) {
      case 'INPROGRESS':
        return SectionProgressStateType.inProgress;
      case 'COMPLETED':
        return SectionProgressStateType.completed;
      case 'NOT_STARTED':
        return SectionProgressStateType.notStarted;
      default:
        return SectionProgressStateType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionProgressStateType.inProgress:
        return 'INPROGRESS';
      case SectionProgressStateType.completed:
        return 'COMPLETED';
      case SectionProgressStateType.notStarted:
        return 'NOT_STARTED';
      default:
        return 'undefined';
    }
  }
}

enum SectionProgressStatusType {
  inactivate,
  activate,
  undefined,
}

extension SectionProgressStatusTypeExt on SectionProgressStatusType {
  static SectionProgressStatusType fromValue(String? value) {
    switch (value) {
      case 'INACTIVATE':
        return SectionProgressStatusType.inactivate;
      case 'ACTIVATE':
        return SectionProgressStatusType.activate;
      default:
        return SectionProgressStatusType.undefined;
    }
  }

  String toValue() {
    switch (this) {
      case SectionProgressStatusType.inactivate:
        return 'INACTIVATE';
      case SectionProgressStatusType.activate:
        return 'ACTIVATE';
      default:
        return 'undefined';
    }
  }
}