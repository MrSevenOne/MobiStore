import 'package:flutter/material.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';
import 'package:mobi_store/data/services/data/supabase/database/phone_report_service.dart';

class PhoneReportViewModel extends ChangeNotifier {
  final PhoneReportService _service = PhoneReportService();

  List<PhoneReportModel> _reports = [];
  List<PhoneReportModel> get reports => _reports;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _currentShopId; // 📌 oxirgi chaqirilgan shopId ni saqlab turish
  String? get currentShopId => _currentShopId;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// 📌 Faqat shopId bo‘yicha reportlarni olish
 Future<List<PhoneReportModel>> fetchReportsByShop(String shopId) async {
  try {
    final reports = await _service.getReportsByShop(shopId);
    _reports = reports;
    notifyListeners();
    return reports; // 🔥 qaytarilmoqda
  } catch (e) {
    debugPrint("Error fetching reports: $e");
    return [];
  }
}


  /// 📌 Telefonni reportga o‘tkazish
  Future<bool> movePhoneToReport({
    required int phoneId,
    required double salePrice,
    required int paymentType,
  }) async {
    if (_currentShopId == null) return false;

    _setLoading(true);
    try {
      final result = await _service.movePhoneToReport(
        phoneId: phoneId,
        salePrice: salePrice,
        paymentType: paymentType,
      );
      if (result) {
        await fetchReportsByShop(_currentShopId!); // ✅ avtomatik yangilash
      }
      return result;
    } catch (e) {
      _setError("Xatolik: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// 📌 Report yangilash
  Future<bool> updateReport(int id, PhoneReportModel data) async {
    _setLoading(true);
    try {
      final result = await _service.updateReport(id, data.toJson());
      if (result && _currentShopId != null) {
        await fetchReportsByShop(_currentShopId!);
      }
      return result;
    } catch (e) {
      _setError("Xatolik: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// 📌 Report o‘chirish
  Future<bool> deleteReport(int id) async {
    _setLoading(true);
    try {
      final result = await _service.deleteReport(id);
      if (result) {
        _reports.removeWhere((r) => r.id == id);
        notifyListeners();
      }
      return result;
    } catch (e) {
      _setError("Xatolik: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
