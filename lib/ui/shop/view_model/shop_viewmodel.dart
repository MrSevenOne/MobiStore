import 'package:mobi_store/export.dart';
import '../../../data/services/data/supabase/database/shop_service.dart';

class ShopViewmodel extends ChangeNotifier {
  final ShopService _shopService = ShopService();

  bool _isLoading = false;
  String? _errorMessage;
  List<ShopModel> _stores = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ShopModel> get stores => _stores;

  /// Store qo‘shish
  Future<void> createStore(String address, String storeName) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _shopService.createStore(address, storeName);
      fetchStores();
    } catch (e) {
      _errorMessage = e.toString();
      rethrow; // UI da ham tutish uchun
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Storelarni olish
  Future<void> fetchStores() async {
    final userId = UserManager.currentUserId!;
    _setLoading(true);
    try {
      _stores = await _shopService.getStoresByUser(userId);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateStore(ShopModel shopModel) async {
    _setLoading(true);
    try {
      await _shopService.updateStore(shopModel);

      final index = _stores.indexWhere((store) => store.id == shopModel.id);
      if (index != -1) {
        _stores[index] = shopModel;
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Store o‘chirish
  Future<void> deleteStore(int id) async {
    _setLoading(true);
    try {
      await _shopService.deleteStore(id);
      _stores.removeWhere((store) => store.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

   /// Store bo‘yicha limitni aniqlash
  Future<bool> checkStoreLimit() async {
    try {
      final result = await _shopService.checkStoreLimit();
      debugPrint("✅ Store limit check result: $result");
      return result; // bool qiymat qaytariladi
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("❌ Store limit check error: $e");
      return false; // xatolik bo‘lsa false qaytadi
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
