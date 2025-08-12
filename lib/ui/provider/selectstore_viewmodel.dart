import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedStoreViewModel extends ChangeNotifier {
  static const _storeIdKey = 'storeId';
  int? _storeId;

  int? get storeId => _storeId;

  /// Store ID saqlash
  Future<void> saveStoreId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_storeIdKey, id);
    _storeId = id;
    notifyListeners();
  }

  /// Saqlangan Store ID ni yuklash
  Future<void> loadStoreId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get(_storeIdKey);

    if (value is int) {
      _storeId = value;
    } else if (value is String) {
      _storeId = int.tryParse(value);
    } else {
      _storeId = null;
    }

    notifyListeners();
  }

  /// Store ID ni tozalash
  Future<void> clearStoreId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storeIdKey);
    _storeId = null;
    notifyListeners();
  }

  /// Tanlangan store mavjudligini tekshirish
  bool get hasSelectedStore => _storeId != null;
}
