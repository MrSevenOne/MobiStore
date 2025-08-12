import 'package:mobi_store/export.dart';
import '../../../data/services/data/store_service.dart';

class StoreViewModel extends ChangeNotifier {
  final StoreService _storeService = StoreService();

  bool _isLoading = false;
  String? _errorMessage;
  List<StoreModel> _stores = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<StoreModel> get stores => _stores;

  /// Store qo‘shish
  Future<void> createStore(String address, String storeName) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _storeService.createStore(address, storeName);
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
      _stores = await _storeService.getStoresByUser(userId);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  /// Store o‘chirish
  Future<void> removeStore(int id) async {
    _setLoading(true);
    try {
      await _storeService.deleteStore(id);
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
      final result = await _storeService.checkStoreLimit();
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
