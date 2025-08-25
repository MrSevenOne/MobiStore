import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobi_store/domain/models/accessory_report_model.dart';
import 'package:mobi_store/data/services/data/supabase/database/accessory_report_service.dart';
import 'package:mobi_store/utils/chart_data.dart';

class AccessoryReportViewModel extends ChangeNotifier {
  final AccessoryReportService service = AccessoryReportService();

  List<AccessoryReportModel> _reports = [];
  List<AccessoryReportModel> get reports => _reports;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _currentStoreId;
  int? get currentStoreId => _currentStoreId;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }


  /// 📌 Store bo‘yicha reportlarni olish
  Future<List<AccessoryReportModel>> fetchReportsByStore(
      int storeId) async {
    try {
      _currentStoreId = storeId;
      final reports = await service.getReportsByShopAndUser(
        shopId: storeId,
      );
      _reports = reports;
      notifyListeners();
      return reports;
    } catch (e) {
      debugPrint("Error fetching reports by store: $e");
      return [];
    }
  }

  /// 📌 Yangi report qo'shish
  Future<bool> addReport({
    required String accessoryId,
    required int saleQuantity,
    required int salePrice,
    required String paymentType,
    required int storeId,
  }) async {
    _setLoading(true);
    try {
      await service.addReport(
        accessoryId: accessoryId,
        saleQuantity: saleQuantity,
        salePrice: salePrice,
        paymentType: paymentType,
        storeId: storeId,
      );
      // avtomatik yangilash
      await fetchReportsByStore(storeId);
      return true;
    } catch (e) {
      _setError("Error adding report: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// 📌 Sana oralig‘idagi reportlar
  List<AccessoryReportModel> getReportsByDateRange(
      DateTime start, DateTime end) {
    return _reports.where((r) {
      final created = r.saleTime;
      return created.isAfter(start.subtract(const Duration(seconds: 1))) &&
          created.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  /// 📌 Kunlik foyda
  List<ChartData> getProfitDataByDateRange(DateTime start, DateTime end) {
    final filtered = getReportsByDateRange(start, end);
    final Map<String, double> dailyProfit = {};
    for (var r in filtered) {
      final day = DateFormat('yyyy-MM-dd').format(r.saleTime);
      dailyProfit[day] =
          (dailyProfit[day] ?? 0) + (r.salePrice - r.accessory!.price);
    }
    return dailyProfit.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();
  }

  /// 📌 Umumiy foyda
  double getTotalProfitByDateRange(DateTime start, DateTime end) {
    final filtered = getReportsByDateRange(start, end);
    return filtered.fold(
        0.0, (sum, r) => sum + (r.salePrice - r.accessory!.price));
  }

  /// 📌 Top 5 sotilgan mahsulot
  List<MapEntry<String, int>> getTop5AccessoriesByDateRange(
      DateTime start, DateTime end) {
    final filtered = getReportsByDateRange(start, end);
    final Map<String, int> productCount = {};
    for (var r in filtered) {
      productCount[r.accessory!.name] =
          (productCount[r.accessory!.name] ?? 0) + r.saleQuantity;
    }
    final sorted = productCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(5).toList();
  }
}
