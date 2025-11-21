import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static DateTime fromSeconds(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds);
  }

  String toFormatString({
    required String format,
    String locale = 'vi',
  }) {
    final formatter = DateFormat(format, locale);
    return formatter.format(this);
  }
}
