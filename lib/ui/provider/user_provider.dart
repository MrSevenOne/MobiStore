import 'package:mobi_store/export.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService(); // 🔹 AuthService qo‘shildi

  UserViewModel(UserService userService);

  bool? _status;
  bool? get status => _status;

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  void _setStatus(bool? value) {
    _status = value;
    notifyListeners();
  }

  void _setUser(UserModel? value) {
    _user = value;
    notifyListeners();
  }

  /// ID bo‘yicha foydalanuvchi ma’lumotini olish
  Future<void> fetchUserById(String id) async {
    _setLoading(true);
    _setError(null);

    try {
      final data = await _userService.getUserById(id);
      _setUser(data);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchUserStatus(String userId) async {
    _setLoading(true);
    _setError(null);
    try {
      final status = await _userService.getUserStatus(userId);
      _setStatus(status);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// 🔹 User ma'lumotini Auth va Users jadvali bo‘yicha yangilash
  Future<void> updateFullUser(UserModel userModel,
      {String? newPassword}) async {
    _setLoading(true);
    _setError(null);

    try {
      // 1️⃣ AuthService orqali email/parol yangilash
      final bool isEmailChanged = userModel.email.isNotEmpty &&
          userModel.email != _authService.getCurrentUser()?.email;

      final bool isPasswordChanged = newPassword != null &&
          newPassword.isNotEmpty &&
          newPassword != "********";

      if (isEmailChanged || isPasswordChanged) {
        await _authService.updateEmailAndPassword(
          newEmail: isEmailChanged ? userModel.email : null,
          newPassword: isPasswordChanged ? newPassword : null,
        );
      }

      // 2️⃣ Users jadvalini update qilish
      await _userService.updateFullUser(userModel);

      // 3️⃣ Yangilangan user ma'lumotini qayta olish
      await fetchUserById(userModel.id!);

      debugPrint("✅ User updated successfully");
    } catch (e) {
      _setError(e.toString());
      debugPrint("❌ Update failed: $e");
    } finally {
      _setLoading(false);
    }
  }
}
