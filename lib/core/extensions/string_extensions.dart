import 'package:smatrackz/core.dart';

extension StringExt on String {
  String get displayTime {
    String hour = substring(0, 2);
    final minute = substring(3, 5);

    return '$hour:$minute';
  }

  String get dayDateMonthYear {
    final dateTime = DateTime.parse(this);
    return DateFormat('EEEE, d MMMM y').format(dateTime);
  }

  String get hourMinute {
    final parts = split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }
    return this;
  }

  double extractNumber() {
    RegExp regex = RegExp(r'\d+(\.\d+)?');

    Match? match = regex.firstMatch(this);

    if (match != null) {
      return double.parse(match.group(0)!);
    } else {
      return 0.0;
    }
  }
}
