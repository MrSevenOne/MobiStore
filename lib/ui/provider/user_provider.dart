import 'package:mobi_store/export.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService;

  UserViewModel(this._userService);

  bool? _status;
  bool? get status => _status;

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
}
