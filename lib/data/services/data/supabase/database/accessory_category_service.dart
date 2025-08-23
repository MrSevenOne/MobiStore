import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';

class AccessoryService extends BaseService{

  AccessoryService(): super('accessories');

  Future<List<AccessoryModel>> getAccessoriesByShop(int shopId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('store_id', shopId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => AccessoryModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("❌ Error fetching accessories: $e");
      rethrow;
    }
  }

  Future<AccessoryModel?> addAccessory(AccessoryModel accessory) async {
    try {
      final response = await supabase
          .from(tableName)
          .insert(accessory.toJson())
          .select()
          .single();

      return AccessoryModel.fromJson(response);
    } catch (e) {
      debugPrint("❌ Error adding accessory: $e");
      return null;
    }
  }

  Future<bool> updateAccessory(String id, Map<String, dynamic> data) async {
    try {
      await supabase.from(tableName).update(data).eq('id', id);
      return true;
    } catch (e) {
      debugPrint("❌ Error updating accessory: $e");
      return false;
    }
  }

  Future<bool> deleteAccessory(String id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      return true;
    } catch (e) {
      debugPrint("❌ Error deleting accessory: $e");
      return false;
    }
  }
}
