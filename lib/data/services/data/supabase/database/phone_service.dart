import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';

class PhoneService extends BaseService {
  PhoneService() : super('phones');

  Future<PhoneModel?> addPhone(PhoneModel phone) async {
    try {
      final response = await supabase
          .from('phones')
          .insert(phone.toJson())
          .select()
          .single();
       return PhoneModel.fromJson(response);
    } catch (e) {
      debugPrint("Error adding phone: $e");
      return null;
    }
  }

  Future<List<PhoneModel>> getPhones() async {
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .order('created_at', ascending: false);
      return (response as List).map((e) => PhoneModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching phones: $e");
      return [];
    }
  }

  Future<bool> updatePhone(PhoneModel phone) async {
    try {
      final response = await supabase
          .from(tableName)
          .update(phone.toJson())
          .eq('id', phone.id!);
      return response.error == null;
    } catch (e) {
      debugPrint("Error updating phone: $e");
      return false;
    }
  }

  Future<bool> deletePhone(int id) async {
    try {
      final response = await supabase.from(tableName).delete().eq('id', id);
      return response.error == null;
    } catch (e) {
      debugPrint("Error deleting phone: $e");
      return false;
    }
  }

  Future<List<PhoneModel>> getPhonesByShop(String shopId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('shop_id', shopId)
          .order('created_at', ascending: false);
      return (response as List).map((e) => PhoneModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching phones by shop: $e");
      return [];
    }
  }
}
