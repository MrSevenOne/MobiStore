import 'package:mobi_store/export.dart';

class UserTariffService extends BaseService {
  UserTariffService() : super('user_tariff');

  /// Upsert - agar user_id bo‘yicha mavjud bo‘lsa update qiladi
  Future<UserTariffModel?> upsertUserTariff(UserTariffModel userTariff) async {
    try {
      debugPrint("📥 Upsert input: ${userTariff.toMap()}");
      final response = await supabase
          .from(tableName)
          .upsert(userTariff.toMap(), onConflict: 'user_id')
          .select('*, tariffs(*)') // tariffs ni ham yuklash uchun qo'shing
          .maybeSingle();

      debugPrint("📡 Upsert response: $response");
      if (response != null) {
        return UserTariffModel.fromMap(response);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error in upsertUserTariff: $e');
      rethrow;
    }
  }

  Future<UserTariffModel?> getUserTariffByUserId(String userId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*,tariffs(*)')
          .eq('user_id', userId)
          .maybeSingle();

      if (response != null) {
        return UserTariffModel.fromMap(response);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error in getUserTariffByUserId: $e');
      rethrow;
    }
  }

  Future<bool> hasUserTariff(String userId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();

      return response != null; //yozuv bolsa TRUE
    } catch (e) {
      debugPrint('❌ Error in hasUserTariff: $e');
      return false; // yozuv yoq bolsa FALSE
    }
  }
}
