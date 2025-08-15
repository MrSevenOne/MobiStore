import 'package:flutter/material.dart';
import 'package:mobi_store/data/services/data/supabase/database/phone_service.dart';
import 'package:mobi_store/domain/models/phone_model.dart';

class PhoneViewModel extends ChangeNotifier {
  final PhoneService _service = PhoneService();

  List<PhoneModel> phones = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPhones() async {
    isLoading = true;
    notifyListeners();

    try {
      phones = await _service.getPhones();
      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load phones";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<PhoneModel?> addPhone(PhoneModel phone) async {
    isLoading = true;
    notifyListeners();

    try {
      final newPhone = await _service.addPhone(phone);
      if (newPhone != null) phones.insert(0, newPhone);
      errorMessage = null;
      return newPhone;
    } catch (e) {
      errorMessage = "Failed to add phone";
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updatePhone(PhoneModel phone) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.updatePhone(phone);
      if (result) {
        int index = phones.indexWhere((p) => p.id == phone.id);
        if (index != -1) phones[index] = phone;
      }
      errorMessage = null;
      return result;
    } catch (e) {
      errorMessage = "Failed to update phone";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deletePhone(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.deletePhone(id);
      if (result) phones.removeWhere((p) => p.id == id);
      errorMessage = null;
      return result;
    } catch (e) {
      errorMessage = "Failed to delete phone";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPhonesByShop(String shopId) async {
    isLoading = true;
    notifyListeners();

    try {
      phones = await _service.getPhonesByShop(shopId);
      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load phones for shop";
    }

    isLoading = false;
    notifyListeners();
  }
}
