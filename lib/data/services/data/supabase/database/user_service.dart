import 'package:mobi_store/export.dart';

class UserService extends BaseService {
  UserService() : super('users');

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response =
          await supabase.from(tableName).select().order('created_at');
      return (response as List).map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      throw 'UserService.getAllUsers error: $e';
    }
  }

  /// Hozirgi foydalanuvchi ma’lumotlarini olish
  Future<UserModel?> getUserById(String id) async {
    try {
      final data =
          await supabase.from(tableName).select().eq('id', id).maybeSingle();

      if (data == null) return null;
      debugPrint('UserData: ${data.toString()}');
      return UserModel.fromMap(data);
    } catch (e) {
      throw 'UserService.getUserById error: $e';
    }
  }

  Future<bool?> getUserStatus(String userId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('status')
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;
      return response['status'] as bool?;
    } catch (e) {
      throw 'UserService.getUserStatus error: $e';
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await supabase.from(tableName).insert(user.toInsertMap());
    } catch (e) {
      throw 'UserService.addUser error: $e';
    }
  }

 

  

   Future<void> updateFullUser(UserModel userModel) async {
  try {
    // faqat 'users' jadvalini update qilish
    await Supabase.instance.client
        .from('users')
        .update({
          'name': userModel.name,
          'email': userModel.email.trim(),
          // agar parol bo'lsa (opsional) yangilash
          if (userModel.password != null &&
              userModel.password!.trim().isNotEmpty)
            'password': userModel.password!.trim(),
        })
        .eq('id', userModel.id!);

    debugPrint("✅ Users jadvali yangilandi");
  } catch (e) {
    debugPrint("❌ Users jadvalini yangilashda xatolik: $e");
    rethrow;
  }
}




  Future<void> deleteUser(String id) async {
    try {
      checkUserId();
      await supabase.from(tableName).delete().eq('id', id);
    } catch (e) {
      throw 'UserService.deleteUser error: $e';
    }
  }

  Stream<List<UserModel>> watchUsers() {
    try {
      return supabase
          .from(tableName)
          .stream(primaryKey: ['id'])
          .order('created_at')
          .map((data) => data.map((e) => UserModel.fromMap(e)).toList());
    } catch (e) {
      throw 'UserService.watchUsers error: $e';
    }
  }
}
