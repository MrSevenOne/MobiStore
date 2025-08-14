// import 'package:flutter/material.dart';
// import 'package:mobi_store/domain/models/user_model.dart';
// import 'package:mobi_store/export.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProfileViewModel extends ChangeNotifier {
//   final UserService _userService = UserService();
//   final SupabaseClient _client = Supabase.instance.client;

//   ProfileViewModel();

//   bool _isLoading = false;
//   String? _error;

//   UserModel? _user;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   UserModel? get user => _user;

//   void _setLoading(bool v) {
//     _isLoading = v;
//     notifyListeners();
//   }

//   void _setError(String? v) {
//     _error = v;
//     notifyListeners();
//   }

//   void _setUser(UserModel? u) {
//     _user = u;
//     notifyListeners();
//   }

//   /// Hozirgi auth foydalanuvchining profilini users jadvalidan olish
//   Future<void> load() async {
//     _setLoading(true);
//     _setError(null);
//     try {
//       final authId = _client.auth.currentUser?.id;
//       if (authId == null) {
//         _setError('Not authenticated');
//         _setLoading(false);
//         return;
//       }
//       final u = await _userService.getUserById(authId);
//       _setUser(u);
//     } catch (e) {
//       _setError(e.toString());
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// Profile’ni saqlash (username/email/password)
//   Future<bool> save({
//     required String name,
//     required String email,
//     String? password, // optional
//   }) async {
//     _setLoading(true);
//     _setError(null);
//     try {
//       final authId = _client.auth.currentUser?.id;
//       if (authId == null) throw 'Not authenticated';

//       final updated = UserModel(
//         id: authId,
//         name: name,
//         email: email,
//         password:password!,
//       );

//       await _userService.updateFullUser(updated);

//       // Local holatni yangilash (parolni UX nuqtai nazaridan saqlamaymiz)
//       _setUser(
//         (_user ?? UserModel(authId)).copyWith(
//           name: name,
//           email: email,
//         ),
//       );

//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
// }
