import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';

class PhoneService extends BaseService {
  PhoneService() : super('phones');

  Future<PhoneModel?> addPhone(PhoneModel phone) async {
    try {
      final response = await supabase
          .from('phones')
          .insert(phone.toJson())
          .select('*, company:company_name(*)')
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
          .from('phones')
          .select('*, company:company_name(*)')
          .order('created_at', ascending: false);

      return (response as List).map((e) => PhoneModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching phones: $e");
      return [];
    }
  }

  Future<PhoneModel?> updatePhone(PhoneModel phone) async {
    try {
      if (phone.id == null) {
        debugPrint("Error updating phone: Telefon ID topilmadi");
        return null;
      }

      final response = await supabase
          .from(tableName)
          .update(phone.toJson())
          .eq('id', phone.id!)
          .select(
              '*, company:company_name(*)') // company ni ham qaytarish uchun
          .maybeSingle();

      if (response == null) {
        debugPrint("Error updating phone: Response null");
        return null;
      }

      if (response is Map &&
          response.containsKey('error') &&
          response['error'] != null) {
        debugPrint("Supabase xatosi: ${response['error']['message']}");
        return null;
      }

      return PhoneModel.fromJson(response); // Full PhoneModel qaytariladi
    } catch (e) {
      debugPrint("Error updating phone: $e");
      return null;
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
          .select('*, company:company_name(*)')
          .eq('shop_id', shopId)
          .order('created_at', ascending: false);
      return (response as List).map((e) => PhoneModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching phones by shop: $e");
      return [];
    }
  }
}
