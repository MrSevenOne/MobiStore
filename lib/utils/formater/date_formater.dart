import 'package:intl/intl.dart';

class AppDateFormatter {
  /// Default format: dd.MM.yyyy
  static String formatDate(DateTime date) {
    return DateFormat("dd.MM.yyyy").format(date);
  }

  /// Vaqt bilan format: dd.MM.yyyy HH:mm
  static String formatDateTime(DateTime date) {
    return DateFormat("dd.MM.yyyy HH:mm").format(date);
  }

  /// Faqat oy va yil: MMMM yyyy
  static String formatMonthYear(DateTime date) {
    return DateFormat("MMMM yyyy").format(date);
  }

  /// Faqat yil: yyyy
  static String formatYear(DateTime date) {
    return DateFormat("yyyy").format(date);
  }
}
