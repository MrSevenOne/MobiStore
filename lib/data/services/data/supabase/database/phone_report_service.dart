import 'package:mobi_store/export.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';

class PhoneReportService extends BaseService {
  PhoneReportService() : super('phone_reports');

  /// 📌 Shop ID bo‘yicha reportlarni olish
  Future<List<PhoneReportModel>> getReportsByShop(String shopId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*, company:company_name(*)')
          .eq('shop_id', shopId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((e) => PhoneReportModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("❌ Error fetching reports by shop: $e");
      return [];
    }
  }

  Future<bool> movePhoneToReport({
    required int phoneId,
    required double salePrice,
    required int paymentType,
  }) async {
    try {
      final response = await supabase.rpc(
        'move_phone_to_report',
        params: {
          'p_phone_id': phoneId,
          'p_sale_price': salePrice,
          'p_payment_type': paymentType,
        },
      );

      // Agar xatolik bo‘lsa, Supabase RPC Future exception tashlaydi
      // Shu sababli qo‘shimcha null check shart emas
      debugPrint('Mahsulot Sotildi: true');
      return true;
    } catch (e) {
      debugPrint("❌ Exception moving phone to report: $e");
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
