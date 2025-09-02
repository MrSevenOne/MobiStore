import 'package:mobi_store/domain/models/currency_model.dart';

class CurrencyHelper {
  // =============================
  //  Formatlash (3 xonadan keyin bo‘sh joy)
  // =============================
  static String _formatWithSpace(double value) {
    final raw = value.toStringAsFixed(1);
    final parts = raw.split('.');
    final number = parts[0];
    final decimals = parts[1];

    final buffer = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      int position = number.length - i;
      buffer.write(number[i]);
      if (position > 1 && position % 3 == 1) {
        buffer.write(' ');
      }
    }

    return "${buffer.toString()}.$decimals";
  }

  // =============================
  //  Numeric konvertatsiya
  // =============================
  static double fromUzsNumeric(double uzsAmount, CurrencyModel currency) {
    return uzsAmount / currency.rate;
  }

  static double toUzsNumeric(double foreignAmount, CurrencyModel currency) {
    return foreignAmount * currency.rate;
  }

  // =============================
  //  Formatlangan natija (string)
  // =============================
  static String fromUzsFormatted(double uzsAmount, CurrencyModel? currency) {
    if (currency == null || currency.rate == 0) {
      return "${_formatWithSpace(uzsAmount)} UZS";
    }
    final converted = uzsAmount / currency.rate;
    return "${_formatWithSpace(converted)} ${currency.ccy}";
  }

  static String toUzsFormatted(double foreignAmount, CurrencyModel? currency) {
    if (currency == null) {
      return "${_formatWithSpace(foreignAmount)} UZS";
    }
    final converted = foreignAmount * currency.rate;
    return "${_formatWithSpace(converted)} UZS";
  }

  static String formatValue(double amount, CurrencyModel? currency) {
    if (currency == null) {
      return "${_formatWithSpace(amount)} UZS";
    }
    return "${_formatWithSpace(amount)} ${currency.ccy}";
  }

  // =============================
  //  String -> Double (universal)
  // =============================
  static double parseToDouble(String input) {
    if (input.trim().isEmpty) return 0.0;

    // faqat raqam va nuqta/vergul qoldiramiz
    String numeric = input.replaceAll(RegExp(r'[^0-9.,]'), '');

    if (numeric.isEmpty) return 0.0;

    // agar bir nechta nuqta/vergul bo‘lsa → oxirgisini decimal sifatida olamiz
    int lastDot = numeric.lastIndexOf('.');
    int lastComma = numeric.lastIndexOf(',');
    int lastSep = lastDot > lastComma ? lastDot : lastComma;

    if (lastSep != -1) {
      String integerPart = numeric.substring(0, lastSep).replaceAll(RegExp(r'[^0-9]'), '');
      String decimalPart = numeric.substring(lastSep + 1).replaceAll(RegExp(r'[^0-9]'), '');
      numeric = "$integerPart.$decimalPart";
    } else {
      numeric = numeric.replaceAll(RegExp(r'[^0-9]'), '');
    }

    return double.tryParse(numeric) ?? 0.0;
  }

}
