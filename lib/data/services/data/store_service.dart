import 'package:mobi_store/export.dart';

class StoreService extends BaseService{
  StoreService() : super('stores');


  /// Yangi store qo‘shish (trigger ishlaydi)
Future<void> createStore(String address, String storeName) async {
  try {
    final response = await supabase.from(tableName).insert({
      'address': address,
      'store_name': storeName,
    }).select();

    debugPrint("✅ Store qo'shildi: $response");
  } catch (e) {
    debugPrint("❌ createStore Error: $e");
    rethrow;
  }
}

 /// Foydalanuvchining barcha storelarini olish
Future<List<StoreModel>> getStoresByUser(String userId) async {
  try {
    final response = await supabase
        .from(tableName)
        .select('*')
        .eq('user_id', userId) // faqat shu userning storelari
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => StoreModel.fromMap(item))
        .toList();
  } catch (e) {
    debugPrint("❌ getStoresByUser Error: $e");
    rethrow;
  }
}

Future<bool> checkStoreLimit() async {
  try {
    final response = await supabase.rpc('check_store_limit');
    debugPrint("✅ checkStoreLimit response: $response");

    return response as bool;
  } catch (e) {
    debugPrint("❌ checkStoreLimit error: $e");
    return false;
  }
}





  /// Store o‘chirish
  Future<void> deleteStore(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }
}
