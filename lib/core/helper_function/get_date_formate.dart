import 'package:intl/intl.dart';

DateTime? safeParseDate(String dateString) {
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    return null;
  }
}

String getDateOnly(String dateString) {
  final dateTime = safeParseDate(dateString);
  if (dateTime == null) return '';

  return DateFormat('d MMMM yyyy', 'ar').format(dateTime);
}

String getTimeOnly(String dateString) {
  final dateTime = safeParseDate(dateString);
  if (dateTime == null) return '';

  return DateFormat('h:mm a', 'ar').format(dateTime);
}

String getDateFormate(String dateString) {
  final dateTime = safeParseDate(dateString);
  if (dateTime == null) return '';

  return DateFormat('h:mm a - d MMMM yyyy', 'ar').format(dateTime);
}

String getMonthName(int month) {
  const months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  return months[month - 1];
}