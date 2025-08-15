import 'package:mobi_store/export.dart';

class SelectedStoreViewModel extends ChangeNotifier {
  static const _storeIdKey = 'storeId';
  int? _storeId;

  SelectedStoreViewModel() {
    _loadOnInit();
  }

  int? get storeId => _storeId;

  Future<void> _loadOnInit() async {
    await loadStoreId();
  }

  Future<void> saveStoreId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_storeIdKey, id);
    _storeId = id;
    notifyListeners();
  }

  Future<void> loadStoreId() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get(_storeIdKey);

    if (value is int) {
      _storeId = value;
    } else if (value is String) {
      _storeId = int.tryParse(value);
    } else {
      _storeId = null;
    }
    notifyListeners();
  }

  Future<void> clearStoreId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storeIdKey);
    _storeId = null;
    notifyListeners();
  }

  bool get hasSelectedStore => _storeId != null;
}
