import 'package:intl/intl.dart';

class DateUtil {

  static List<DateTime> getSixDaysDate() {
    final dates = <DateTime>[];
    final currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final date = currentDate.add(Duration(days: i));
      dates.add(date);
    }

    return dates;
  }

  static String getFormattedDateWithYear(DateTime dateTime) {
    final formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(dateTime);
  }

  static int getDateFromDateTime(DateTime dateTime) {
    return dateTime.day;
  }

  static String getDayFromDate(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  static String getFormattedDateForAPI(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String getTimeForFeelingList(DateTime dateTime) {
    final hours = dateTime.hour;
    print('hours: $hours');
    if (hours >= 9 && hours <= 12) {
      return '9 AM  - 12 PM';
    } else if (hours >= 13 && hours < 16){
      return '1 PM - 4 PM';
    } else if (hours >= 16 && hours <= 18) {
      return '4 PM - 6 PM';
    }
    return '';
  }
}