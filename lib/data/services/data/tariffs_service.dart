
import 'package:mobi_store/export.dart';

class TariffService extends BaseService{
   TariffService() : super('tariffs');


  Future<List<TariffModel>> getAllTariffs() async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*')
          .order('created_at');
      return (response as List).map((e) => TariffModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('❌ Error fetching tariffs: $e');
      rethrow;
    }
  }

  Future<TariffModel?> getTariffById(String id) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*')
          .eq('id', id)
          .maybeSingle();
      if (response != null) {
        return TariffModel.fromMap(response);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error fetching tariff by id: $e');
      rethrow;
    }
  }

}
