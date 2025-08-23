import 'package:mobi_store/export.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';

class AccessoryService extends BaseService{

  AccessoryService():super('accessories');

  Future<List<AccessoryModel>> getAccessories() async {
    try {
      final response = await supabase.from(tableName).select();
      return (response as List)
          .map((e) => AccessoryModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('❌ Error fetching accessories: $e');
      return [];
    }
  }

  Future<AccessoryModel?> addAccessory(AccessoryModel accessory) async {
    try {
      final response =
          await supabase.from(tableName).insert(accessory.toJson()).select().single();
      return AccessoryModel.fromJson(response);
    } catch (e) {
      debugPrint('❌ Error adding accessory: $e');
      return null;
    }
  }

  Future<bool> updateAccessory(String id, Map<String, dynamic> data) async {
    try {
      await supabase.from(tableName).update(data).eq('id', id);
      return true;
    } catch (e) {
      debugPrint('❌ Error updating accessory: $e');
      return false;
    }
  }

  Future<bool> deleteAccessory(String id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      return true;
    } catch (e) {
      debugPrint('❌ Error deleting accessory: $e');
      return false;
    }
  }
}
