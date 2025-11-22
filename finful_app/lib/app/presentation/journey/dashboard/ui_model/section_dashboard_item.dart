
import 'package:finful_app/app/data/enum/section.dart';

class SectionDashboardItem {
  final bool isCompleted;
  final bool isActivated;
  final SectionType sectionType;

  SectionDashboardItem({
    required this.isCompleted,
    required this.isActivated,
    required this.sectionType,
  });
}