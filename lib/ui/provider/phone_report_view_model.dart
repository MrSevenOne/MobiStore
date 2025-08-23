import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';
import 'package:mobi_store/data/services/data/supabase/database/phone_report_service.dart';
import 'package:mobi_store/utils/chart_data.dart';

class PhoneReportViewModel extends ChangeNotifier {
  final PhoneReportService _service = PhoneReportService();

  List<PhoneReportModel> _reports = [];
  List<PhoneReportModel> get reports => _reports;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _currentShopId;
  String? get currentShopId => _currentShopId;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// 📌 Shop bo‘yicha reportlarni olish
  Future<List<PhoneReportModel>> fetchReportsByShop(String shopId) async {
    try {
      _currentShopId = shopId;
      final reports = await _service.getReportsByShop(shopId);
      _reports = reports;
      notifyListeners();
      return reports;
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

  List<PhoneReportModel> getReportsByDateRange(DateTime start, DateTime end) {
    return _reports.where((r) {
      final created = r.saleTime; // DateTime tipida bo'lishi kerak
      return created.isAfter(start.subtract(const Duration(seconds: 1))) &&
          created.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

//kunlik reportlar
  List<ChartData> getProfitDataByDateRange(DateTime start, DateTime end) {
    final filtered = getReportsByDateRange(start, end);

    // Kun bo‘yicha summani hisoblaymiz
    final Map<String, double> dailyProfit = {};
    for (var r in filtered) {
      final day = DateFormat('yyyy-MM-dd').format(r.saleTime);
      dailyProfit[day] = (dailyProfit[day] ?? 0) + (r.salePrice - r.price);
    }

    return dailyProfit.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();
  }

  /// 📌 Sana oralig‘idagi barcha reportlar bo‘yicha umumiy foydani hisoblaydi
  double getTotalProfitByDateRange(DateTime start, DateTime end) {
    final filtered = getReportsByDateRange(start, end);

    double totalProfit = 0.0;
    for (var r in filtered) {
      totalProfit += (r.salePrice - r.price); // salePrice - buy_price
    }

    return totalProfit;
  }

  /// 📌 Sana oralig‘ida eng ko‘p sotilgan 5 ta model
  List<MapEntry<String, int>> getTop5ModelsByDateRange(
    DateTime start, DateTime end) {
  final filtered = getReportsByDateRange(start, end);

  debugPrint("📊 Tanlangan sana oralig‘ida: ${filtered.length} dona report topildi");

  final Map<String, int> modelCount = {};
  for (var r in filtered) {
    // debugPrint("✅ ${r.modelName} sotilgan | Sana: ${r.saleTime}");
    modelCount[r.modelName] = (modelCount[r.modelName] ?? 0) + 1;
  }

  final sorted = modelCount.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return sorted.take(5).toList();
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
