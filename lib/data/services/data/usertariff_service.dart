import 'package:mobi_store/export.dart';

class UserTariffService extends BaseService {
  UserTariffService() : super('user_tariff');

  /// Upsert - agar user_id bo‘yicha mavjud bo‘lsa update qiladi
  Future<UserTariffModel?> upsertUserTariff(UserTariffModel userTariff) async {
    try {
      final response = await supabase
          .from(tableName)
          .upsert(userTariff.toMap(), onConflict: 'user_id')
          .select()
          .maybeSingle();

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
          .select('*')
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

  Future<void> deleteUserTariff(String userId) async {
    try {
      await supabase
          .from(tableName)
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      debugPrint('❌ Error in deleteUserTariff: $e');
      rethrow;
    }
  }
}
