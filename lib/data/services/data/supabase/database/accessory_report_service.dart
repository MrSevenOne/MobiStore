import 'package:mobi_store/domain/models/accessory_report_model.dart';
import 'package:mobi_store/export.dart';

class AccessoryReportService extends BaseService {
  AccessoryReportService() : super('accessory_reports');

  Future<void> addReport({
    required String accessoryId,
    required int saleQuantity,
    required int salePrice,
    required String paymentType,
    required int storeId,
  }) async {
    try {
      await supabase.rpc('sell_accessory', params: {
        'p_accessory_id': accessoryId,
        'p_sale_quantity': saleQuantity,
        'p_sale_price': salePrice,
        'p_payment_type': paymentType,
        'p_store_id': storeId,
      });
      debugPrint('Accessory sold successfully');
    } catch (e) {
      debugPrint('AccessoryReportService.addReport exception: $e');
    }
  }

  Future<List<AccessoryReportModel>> getReportsByShopAndUser({
    required int shopId,
  }) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*, accessory:accessories(*)') // Accessory ni join qilamiz
          .eq('store_id', shopId)
          .order('sale_time', ascending: false);

      return (response as List)
          .map((json) => AccessoryReportModel.fromMap(json))
          .toList();
    } catch (e) {
      debugPrint(
          "❌ Error fetching accessory reports by shop and user with accessory: $e");
      rethrow;
    }
  }
}
