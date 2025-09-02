import 'package:mobi_store/export.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _authService.getCurrentUser();
  // ✅ Supabase authState stream qo‘shildi
  Stream<AuthState> get authState =>
      Supabase.instance.client.auth.onAuthStateChange;

  Future<void> signUp(UserModel userModel) async {
    _setLoading(true);
    try {
      await _authService.signUp(email: userModel.email, password: userModel.password);
      await _userService.addUser(userModel);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signIn(String email,password) async {
    _setLoading(true);
    try {
      await _authService.signIn(
          email: email, password: password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
