import 'package:smatrackz/core.dart';

extension TimeExt on DateTime {
  /// 01:34:43
  String get clockFormat {
    final now = DateTime.now();
    return DateFormat("H:mm:ss").format(now);
  }

  /// 01:34
  String extractHourMinute() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// 09 November 2023
  String get dateFormat {
    final now = DateTime.now();
    return DateFormat("dd MMMM yyyy").format(now);
  }

  /// 2023-11-09
  String yearMonthDay() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
