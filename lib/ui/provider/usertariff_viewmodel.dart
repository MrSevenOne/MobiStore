import 'package:mobi_store/export.dart';

class UserTariffViewModel extends ChangeNotifier {
  final UserTariffService _service = UserTariffService();

  bool _isLoading = false;
  String? _errorMessage;
  UserTariffModel? _userTariff;
  bool _userTariffBuyStatus = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserTariffModel? get userTariff => _userTariff;
  bool get userTariffStatus => _userTariffBuyStatus;


/// GET USER ID
  final userId = UserManager.currentUserId;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchUserTariff(String userId) async {
    _setLoading(true);
    try {
      _userTariff = await _service.getUserTariffByUserId(userId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  /// 🔹 Yangi umumiy metod: tarif sotib olish
  Future<bool> buyTariff({
    required String userId,
    required TariffModel tariff,
  }) async {
    _setLoading(true);
    try {
      final now = DateTime.now();
      final endDate = now.add(
        Duration(days: tariff.durationDays),
      );

      final newUserTariff = UserTariffModel(
        userId: userId,
        tariffId: tariff.id,
        startDate: now,
        endDate: endDate,
        isActive: true,
      );

      _userTariff = await _service.upsertUserTariff(newUserTariff);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 User'da tarif bor-yo‘qligini tekshirish
  /// 🔹 User'da tarif bor-yo‘qligini tekshirish
  Future<bool> hasUserTariff() async {
    try {
      final hasTariff = await _service.hasUserTariff(userId!);
      _userTariffBuyStatus = hasTariff;
      return hasTariff;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
