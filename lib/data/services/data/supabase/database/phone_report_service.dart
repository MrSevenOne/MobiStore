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

  Future<PhoneReportModel?> addReport(PhoneReportModel report) async {
    try {
      final response =
          await supabase.from(tableName).insert(report.toJson()).select().single();
      return PhoneReportModel.fromJson(response);
    } catch (e) {
      debugPrint("❌ Error inserting phone report: $e");
      return null;
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
