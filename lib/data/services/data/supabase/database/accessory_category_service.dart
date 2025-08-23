import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobi_store/domain/models/accessory_category_model.dart';

class AccessoryCategoryService {
  final _supabase = Supabase.instance.client;
  final String table = 'accessory_categories';

  Future<List<AccessoryCategoryModel>> getCategories() async {
    try {
      final response = await _supabase.from(table).select();
      return (response as List)
          .map((e) => AccessoryCategoryModel.fromJson(e))
          .toList();
    } catch (e) {
      print('❌ Error fetching categories: $e');
      return [];
    }
  }

  Future<AccessoryCategoryModel?> addCategory(String name) async {
    try {
      final response = await _supabase
          .from(table)
          .insert({'name': name})
          .select()
          .single();
      return AccessoryCategoryModel.fromJson(response);
    } catch (e) {
      print('❌ Error adding category: $e');
      return null;
    }
  }

  Future<bool> updateCategory(String id, String name) async {
    try {
      await _supabase.from(table).update({'name': name}).eq('id', id);
      return true;
    } catch (e) {
      print('❌ Error updating category: $e');
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      await _supabase.from(table).delete().eq('id', id);
      return true;
    } catch (e) {
      print('❌ Error deleting category: $e');
      return false;
    }
  }
}
