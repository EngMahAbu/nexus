import 'package:intl/intl.dart';

// TODO: place this into a suitable directory

class DateTimeHelper {
  static const String dateTimePattern = 'd MMMM yyyy hh:mm a';
  static const String timeOnlyPattern = 'hh:mm a';

  static String getCurrentDateTime() {
    return DateFormat(dateTimePattern).format(DateTime.now());
  }

  static String formatTime(String dateTimeInput) {
    DateTime dateTime = DateFormat(dateTimePattern).parse(dateTimeInput);
    return DateFormat(timeOnlyPattern).format(dateTime);
  }
}
