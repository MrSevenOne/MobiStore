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
      _currencies = await CurrencyService().fetchCurrencies(); // API call
      await _restoreSelectedCurrency();
      notifyListeners();
    } catch (e) {
      debugPrint("Currency load error: $e");
    }
  }

  /// Valyutani tanlash
  Future<void> setCurrency(CurrencyModel currency) async {
    _selectedCurrency = currency;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCurrencyCcy', currency.ccy);
  }

  /// Xotiradan tanlangan valyutani tiklash
  Future<void> _restoreSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCcy = prefs.getString('selectedCurrencyCcy');

    if (savedCcy != null && _currencies.isNotEmpty) {
      _selectedCurrency = _currencies.firstWhere(
        (c) => c.ccy == savedCcy,
        orElse: () => _currencies.first,
      );
    }
  }

  // =========================
  // UI uchun yordamchi
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
