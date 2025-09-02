import 'package:flutter/material.dart';
import 'package:mobi_store/data/services/data/supabase/database/company_service.dart';
import 'package:mobi_store/domain/models/company_model.dart';

class CompanyViewModel extends ChangeNotifier {
  final CompanyService _service = CompanyService();

  List<CompanyModel> companies = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchCompanies() async {
    isLoading = true;
    notifyListeners();

    try {
      companies = await _service.getCompanies();
      errorMessage = null;
    } catch (e) {
      errorMessage = "Failed to load companies";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<CompanyModel?> addCompany(CompanyModel company) async {
    isLoading = true;
    notifyListeners();

    try {
      final newCompany = await _service.addCompany(company);
      if (newCompany != null) companies.insert(0, newCompany);
      errorMessage = null;
      return newCompany;
    } catch (e) {
      errorMessage = "Failed to add company";
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateCompany(CompanyModel company) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.updateCompany(company);
      if (result) {
        int index = companies.indexWhere((c) => c.id == company.id);
        if (index != -1) companies[index] = company;
      }
      errorMessage = null;
      return result;
    } catch (e) {
      errorMessage = "Failed to update company";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteCompany(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.deleteCompany(id);
      if (result) companies.removeWhere((c) => c.id == id);
      errorMessage = null;
      return result;
    } catch (e) {
      errorMessage = "Failed to delete company";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
