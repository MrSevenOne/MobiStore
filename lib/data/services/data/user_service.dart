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

  Future<UserModel?> getUserById(String id) async {
    final userId = UserManager.currentUserId;

    try {
      final data =
          await supabase.from(tableName).select().eq('id', userId!).single();
      debugPrint('UserData:${data.toString()}');
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

    if (response == null) return null; // user topilmadi
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

  Future<void> updateUser(UserModel user) async {
    try {
      checkUserId();
      await supabase
          .from(tableName)
          .update(user.toInsertMap())
          .eq('id', user.id!);
    } catch (e) {
      throw 'UserService.updateUser error: $e';
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
