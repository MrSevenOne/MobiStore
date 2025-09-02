import 'package:shared_preferences/shared_preferences.dart';

class CurrencyPreference {
  static const String _key = "selected_currency";

  static Future<void> saveCurrency(String ccy) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, ccy);
  }

  static Future<String?> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
