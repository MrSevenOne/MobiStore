import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceFormatter {
  static final NumberFormat _formatter = NumberFormat.decimalPattern('uz_UZ');

  /// Faqat raqamlarni formatlash (10 000)
  static String formatNumber(num amount) {
    return _formatter.format(amount);
  }

  /// Raqam + "so'm" formatida (10 000 so'm)
  static String formatNumberSom(num amount) {
    return "${_formatter.format(amount)} so'm";
  }

  /// TextField uchun input formatter
  static TextInputFormatter inputFormatter() {
    return _CurrencyInputFormatter();
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('uz_UZ');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // faqat raqamlarni olib qolish
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final number = int.parse(newText);
    final formatted = _formatter.format(number);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
