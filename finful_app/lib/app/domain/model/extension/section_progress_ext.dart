import 'package:finful_app/app/data/enum/section_progress.dart';
import 'package:finful_app/app/domain/model/section_progress_model.dart';

extension SectionProgressExt on SectionProgressModel {
  bool get isSectionOnboardingCompleted {
    if (quickCheck == null) return false;

    return quickCheck!.state == SectionProgressStateType.completed;
  }

  bool get isSectionFamilySupportCompleted {
    if (quickCheck == null) return false;

    return familySupport!.state == SectionProgressStateType.completed;
  }

  bool get isSectionSpendingCompleted {
    if (spending == null) return false;

    return spending!.state == SectionProgressStateType.completed;
  }

  bool get isSectionAssumptionsCompleted {
    if (assumptions == null) return false;

    return assumptions!.state == SectionProgressStateType.completed;
  }

  bool get isSectionOnboardingActivated {
    if (quickCheck == null) return false;

    return quickCheck!.status == SectionProgressStatusType.activate;
  }

  bool get isSectionFamilySupportActivated {
    if (quickCheck == null) return false;

    return familySupport!.status == SectionProgressStatusType.activate;
  }

  bool get isSectionSpendingActivated {
    if (spending == null) return false;

    return spending!.status == SectionProgressStatusType.activate;
  }

  bool get isSectionAssumptionsActivated {
    if (assumptions == null) return false;

    return assumptions!.status == SectionProgressStatusType.activate;
  }
}