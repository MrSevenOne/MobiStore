import 'package:mobi_store/export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Ro'yxatdan o'tkazish
  Future<AuthResponse?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw 'AuthService.signUp error: $e';
    }
  }

  // Tizimga kirish
  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      debugPrint('AuthService.signIn error: $e');
      throw 'AuthService.signIn error: $e';
    }
  }
    // Email yangilash
  Future<void> updateEmail(String newEmail) async {
    try {
      await _client.auth.updateUser(UserAttributes(email: newEmail));
    } catch (e) {
      throw 'AuthService.updateEmail error: $e';
    }
  }

  // Parol yangilash
  Future<void> updatePassword(String newPassword) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: newPassword));
    } catch (e) {
      throw 'AuthService.updatePassword error: $e';
    }
  }

  // Chiqish
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw 'AuthService.signOut error: $e';
    }
  }

  // Hozirgi foydalanuvchini olish
  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  // Real-time auth listener
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}
