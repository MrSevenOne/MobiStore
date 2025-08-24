import 'package:mobi_store/export.dart';
import 'package:mobi_store/domain/models/accessory_category_model.dart';

class AccessoryCategoryService extends BaseService {
  AccessoryCategoryService() : super('accessory_categories');

  Future<List<AccessoryCategoryModel>> getCategories() async {
    try {
      final response = await supabase.from(tableName).select();
      debugPrint("Accessory Category: $response");
      return (response as List)
          .map((e) => AccessoryCategoryModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('❌ Error fetching categories: $e');
      return [];
    }
  }

  Future<int> getAccessoryCountByCategory(String categoryId) async {
    try {
      final response = await supabase.rpc(
        'get_accessory_count_by_category',
        params: {'cat_id': categoryId}, // uuid string sifatida
      );

      if (response != null) {
        return response as int;
      } else {
        return 0;
      }
    } catch (e) {
      debugPrint("❌ Error fetching accessory count: $e");
      return 0;
    }
  }
}
