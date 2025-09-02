import 'package:mobi_store/export.dart';

class ShopService extends BaseService{
  ShopService() : super('stores');


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
Future<List<ShopModel>> getStoresByUser(String userId) async {
  try {
    final response = await supabase
        .from(tableName)
        .select('*')
        .eq('user_id', userId) // faqat shu userning storelari
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => ShopModel.fromMap(item))
        .toList();
  } catch (e) {
    debugPrint("❌ getStoresByUser Error: $e");
    rethrow;
  }
}

/// ID bo‘yicha bitta store olish
Future<ShopModel?> getStoreById(int id) async {
  try {
    final response = await supabase
        .from(tableName)
        .select('*')
        .eq('id', id)
        .maybeSingle(); // faqat bitta qiymat qaytaradi

    if (response == null) {
      debugPrint("⚠️ Store topilmadi (id: $id)");
      return null;
    }

    return ShopModel.fromMap(response);
  } catch (e) {
    debugPrint("❌ getStoreById Error: $e");
    rethrow;
  }
}



/// Store tahrirlash
Future<void> updateStore(ShopModel storeModel) async {
  try {
    final response = await supabase
        .from(tableName)
        .update({
          'address': storeModel.address,
          'store_name': storeModel.storeName,
        })
        .eq('id', storeModel.id!)
        .select();

    debugPrint("✅ Store yangilandi: $response");
  } catch (e) {
    debugPrint("❌ updateStore Error: $e");
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
