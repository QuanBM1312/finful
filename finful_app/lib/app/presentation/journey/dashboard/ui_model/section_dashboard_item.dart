
import 'package:finful_app/app/data/enum/section.dart';

class SectionDashboardItem {
  final bool isCompleted;
  final bool isActivated;
  final String bgImage;
  final String image;
  final String content;
  final SectionType sectionType;

  SectionDashboardItem({
    required this.isCompleted,
    required this.isActivated,
    required this.bgImage,
    required this.image,
    required this.content,
    required this.sectionType,
  });

  SectionDashboardItem copyWith({
    final bool? isCompleted,
    final bool? isActivated,
  }) {
    return SectionDashboardItem(
      isCompleted: isCompleted ?? this.isActivated,
      isActivated: isActivated ?? this.isActivated,
      bgImage: bgImage,
      image: image,
      content: content,
      sectionType: sectionType,
    );
  }
}