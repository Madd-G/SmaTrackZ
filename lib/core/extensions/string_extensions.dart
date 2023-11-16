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

  Icon toStatusIcon() {
    switch (toLowerCase()) {
      case 'leave':
        return const Icon(
          Ionicons.today,
          color: AppColors.greenColor,
          size: 25.0,
        );
      case 'sick':
        return const Icon(
          Icons.local_hospital_rounded,
          color: AppColors.greenColor,
          size: 25.0,
        );
      case 'no permission':
        return const Icon(
          CupertinoIcons.clear_circled_solid,
          color: AppColors.redColor,
        );
      default:
        return const Icon(
          Icons.error_outlined,
          color: AppColors.yellowColor,
          size: 25.0,
        );
    }
  }
}
