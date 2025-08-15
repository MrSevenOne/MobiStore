import 'package:mobi_store/domain/models/company_model.dart';
import 'package:mobi_store/export.dart';

class CompanyService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<CompanyModel?> addCompany(CompanyModel company) async {
    try {
      final response = await supabase.from('company_name').insert(company.toJson()).select().single();
      return CompanyModel.fromJson(response);
    } catch (e) {
      debugPrint("Error adding company: $e");
      return null;
    }
  }

  Future<List<CompanyModel>> getCompanies() async {
    try {
      final response = await supabase.from('company_name').select().order('created_at', ascending: false);
      return (response as List).map((e) => CompanyModel.fromJson(e)).toList();
    } catch (e) {
     debugPrint("Error fetching companies: $e");
      return [];
    }
  }

  Future<bool> updateCompany(CompanyModel company) async {
    try {
      final response = await supabase.from('company_name').update(company.toJson()).eq('id', company.id!);
      return response.error == null;
    } catch (e) {
      debugPrint("Error updating company: $e");
      return false;
    }
  }

  Future<bool> deleteCompany(String id) async {
    try {
      final response = await supabase.from('company_name').delete().eq('id', id);
      return response.error == null;
    } catch (e) {
      debugPrint("Error deleting company: $e");
      return false;
    }
  }
}
