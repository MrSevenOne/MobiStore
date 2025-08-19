import 'package:mobi_store/export.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';

class PhoneReportService extends BaseService {
  PhoneReportService() : super('phone_reports');

  Future<List<PhoneReportModel>> getReports() async {
    try {
      final response = await supabase.from(tableName).select();
      return (response as List)
          .map((e) => PhoneReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("❌ Error fetching phone reports: $e");
      rethrow;
    }
  }

  Future<PhoneReportModel?> getReportById(int id) async {
    try {
      final response =
          await supabase.from(tableName).select().eq('id', id).single();
      return PhoneReportModel.fromJson(response);
    } catch (e) {
      debugPrint("❌ Error fetching phone report by id: $e");
      return null;
    }
  }

  /// ✅ Function orqali qo‘shish (phones → phone_reports)
  Future<bool> movePhoneToReport({
    required int phoneId,
    required double salePrice,
    required int paymentType,
  }) async {
    try {
      await supabase.rpc('move_phone_to_report', params: {
        'p_phone_id': phoneId,
        'p_sale_price': salePrice,
        'p_payment_type': paymentType,
      });
      debugPrint("✅ Phone moved to report successfully!");
      return true;
    } catch (e) {
      debugPrint("❌ Error moving phone to report: $e");
      return false;
    }
  }

  Future<bool> updateReport(int id, Map<String, dynamic> data) async {
    try {
      await supabase.from(tableName).update(data).eq('id', id);
      return true;
    } catch (e) {
      debugPrint("❌ Error updating phone report: $e");
      return false;
    }
  }

  Future<bool> deleteReport(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      return true;
    } catch (e) {
      debugPrint("❌ Error deleting phone report: $e");
      return false;
    }
  }
}
