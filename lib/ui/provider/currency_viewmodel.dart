import 'package:flutter/foundation.dart';
import 'package:mobi_store/data/services/currency_service.dart';
import 'package:mobi_store/domain/models/currency_model.dart';
import 'package:mobi_store/utils/helper/currency_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyViewModel extends ChangeNotifier {
  CurrencyModel? _selectedCurrency;
  List<CurrencyModel> _currencies = [];

  CurrencyModel? get selectedCurrency => _selectedCurrency;
  List<CurrencyModel> get currencies => _currencies;

  /// API dan valyutalar ro‘yxatini olish
  Future<void> loadCurrencies() async {
    try {
      _currencies = await CurrencyService().fetchCurrencies(); // API dan ma'lumotlarni olish
      await _restoreSelectedCurrency(); // Tanlangan valyutani tiklash
      notifyListeners(); // UI ni yangilash
    } catch (e) {
      debugPrint("Valyuta yuklashda xato: $e");
    }
  }

  /// Valyutani tanlash va saqlash
  Future<void> setCurrency(CurrencyModel currency) async {
    _selectedCurrency = currency;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCurrencyCcy', currency.ccy); // Tanlangan valyutani saqlash
  }

  /// Xotiradan tanlangan valyutani tiklash yoki default UZS ni o‘rnatish
  Future<void> _restoreSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCcy = prefs.getString('selectedCurrencyCcy');

    if (savedCcy != null && _currencies.isNotEmpty) {
      // Agar xotirada saqlangan valyuta bo‘lsa, uni topish
      _selectedCurrency = _currencies.firstWhere(
        (c) => c.ccy == savedCcy,
        orElse: () => _currencies.firstWhere(
          (c) => c.ccy == 'UZS', // Agar saqlangan valyuta topilmasa, UZS ni tanlash
          orElse: () => _currencies.first, // Agar UZS topilmasa, birinchi valyuta
        ),
      );
    } else {
      // Agar xotirada hech qanday valyuta saqlanmagan bo‘lsa, UZS ni default qilish
      _selectedCurrency = _currencies.firstWhere(
        (c) => c.ccy == 'UZS',
        orElse: () => _currencies.first, // Agar UZS topilmasa, birinchi valyuta
      );
      // Default valyutani xotiraga saqlash
      await prefs.setString('selectedCurrencyCcy', _selectedCurrency!.ccy);
    }
  }

  // =========================
  // UI uchun yordamchi funksiyalar
  // =========================
  String formatFromUzs(double amount) =>
      CurrencyHelper.fromUzsFormatted(amount, _selectedCurrency);

  String formatToUzs(double amount) =>
      CurrencyHelper.toUzsFormatted(amount, _selectedCurrency);

  String formatValue(double amount) =>
      CurrencyHelper.formatValue(amount, _selectedCurrency);

  double fromUzsNumeric(double amount) =>
      CurrencyHelper.fromUzsNumeric(amount, _selectedCurrency!);

  double toUzsNumeric(double amount) =>
      CurrencyHelper.toUzsNumeric(amount, _selectedCurrency!);
}