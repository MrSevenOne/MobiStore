import 'package:mobi_store/data/services/data/supabase/database/accessory_category_service.dart';
import 'package:mobi_store/domain/models/accessory_category_model.dart';
import 'package:mobi_store/export.dart';

class AccessoryCategoryViewModel extends ChangeNotifier {
  final AccessoryCategoryService _service = AccessoryCategoryService();

  List<AccessoryCategoryModel> _categories = [];
  List<AccessoryCategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final Map<String, int> _categoryCounts = {};
  Map<String, int> get categoryCounts => _categoryCounts;

  /// Fetch all categories va countlarni **parallel** olish
  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _service.getCategories();

      // parallel fetch: barcha category counts bir vaqtda
      final futures = _categories.map((c) async {
        try {
          final count = await _service.getAccessoryCountByCategory(c.id);
          _categoryCounts[c.id] = count;
          debugPrint("fetchCategories $_categories");
        } catch (_) {
          _categoryCounts[c.id] = 0;
        }
      }).toList();

      await Future.wait(futures);
    } catch (e) {
      _errorMessage = "Failed to fetch categories";
      debugPrint("❌ fetchCategories error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
