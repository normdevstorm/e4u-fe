import 'package:e4u_application/app/utils/functions/date_converter.dart';

extension DateUtil on DateTime {
  // Basic date utility extensions
  // Add more specific date formatting methods as needed

  /// Format date to string (yyyy-MM-dd)
  String toDateString() {
    return DateConverter.convertToYearMonthDay(this);
  }

  /// Format time to string (HH:mm:ss)
  String toTimeString() {
    return DateConverter.convertToHourMinuteSecond(this);
  }

  /// Get weekday string
  String get weekdayString {
    return DateConverter.getWeekdayString(this);
  }

  /// Check if this date is the same day as another date
  bool getIsSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
