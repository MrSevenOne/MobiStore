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

  /// Har bir kategoriya uchun count saqlash
  final Map<String, int> _categoryCounts = {};
  Map<String, int> get categoryCounts => _categoryCounts;

  /// Bitta category uchun count olish
  Future<void> fetchAccessoryCount(String categoryId) async {
    try {
      final count = await _service.getAccessoryCountByCategory(categoryId);
      _categoryCounts[categoryId] = count;
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error fetching accessory count: $e");
      _categoryCounts[categoryId] = 0;
      notifyListeners();
    }
  }

  /// Fetch all categories va countlarni ham olish
  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _service.getCategories();

      // har bir category uchun count olish
      for (var category in _categories) {
        await fetchAccessoryCount(category.id);
      }
    } catch (e) {
      _errorMessage = "Failed to fetch categories";
      print("❌ fetchCategories error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
