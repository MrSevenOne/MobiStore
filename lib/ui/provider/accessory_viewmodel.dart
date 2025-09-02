import 'package:flutter/material.dart';
import 'package:mobi_store/data/services/data/supabase/database/accessory_service.dart';
import '../../domain/models/accessory_model.dart';

class AccessoryViewModel extends ChangeNotifier {
  final AccessoryService _repository = AccessoryService();

  List<AccessoryModel> _accessories = [];
  List<AccessoryModel> get accessories => _accessories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAccessories(int shopId, String categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _accessories = await _repository.getAccessories(shopId, categoryId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // AccessoryViewModel
  Future<AccessoryModel?> addAccessory(AccessoryModel accessory) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newAccessory = await _repository
          .addAccessory(accessory); // repository ham AccessoryModel? qaytarsin
      if (newAccessory != null) {
        _accessories.insert(0, newAccessory);
        return newAccessory;
      } else {
        _errorMessage = "Accessory qo‘shishda xatolik yuz berdi";
        return null;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAccessory(String id, Map<String, dynamic> data) async {
    final success = await _repository.updateAccessory(id, data);
    if (success) {
      final index = _accessories.indexWhere((a) => a.id == id);
      if (index != -1) {
        _accessories[index] =
            AccessoryModel.fromJson({..._accessories[index].toJson(), ...data});
      }
      notifyListeners();
    }
  }

  Future<void> deleteAccessory(String id) async {
    final success = await _repository.deleteAccessory(id);
    if (success) {
      _accessories.removeWhere((a) => a.id == id);
      notifyListeners();
    }
  }
}
