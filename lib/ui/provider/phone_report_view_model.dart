import 'package:flutter/foundation.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';
import 'package:mobi_store/data/services/data/supabase/database/phone_report_service.dart';

class PhoneReportViewModel extends ChangeNotifier {
  final PhoneReportService _service = PhoneReportService();

  List<PhoneReportModel> _reports = [];
  bool _isLoading = false;
  String? _error;

  List<PhoneReportModel> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchReports() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _reports = await _service.getReports();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// ✅ phones → phone_reports function orqali ko‘chirish
  Future<void> movePhoneToReport({
    required int phoneId,
    required double salePrice,
    required int paymentType,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _service.movePhoneToReport(
        phoneId: phoneId,
        salePrice: salePrice,
        paymentType: paymentType,
      );

      if (success) {
        // 🔄 qayta yuklab qo‘yish
        await fetchReports();
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteReport(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _service.deleteReport(id);
      if (success) {
        _reports.removeWhere((r) => r.id == id);
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
