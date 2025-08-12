import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/provider/user_provider.dart';

class SplashViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final UserViewModel _userViewModel = UserViewModel(UserService());
  final UserTariffViewModel _userTariffViewModel = UserTariffViewModel();
  SelectedStoreViewModel storeProvider = SelectedStoreViewModel();

  String? _targetRoute;
  String? get targetRoute => _targetRoute;

  Future<void> handleStartupLogic() async {
    final session = _client.auth.currentSession;

    if (session == null) {
      _targetRoute = AppRouter.login;
      return;
    }

    final userId = session.user.id;
    await _userViewModel.fetchUserStatus(userId);
    final hasTariff = await _userTariffViewModel.hasUserTariff();
    final status = _userViewModel.status;
////
    await storeProvider.loadStoreId();

    //User tabledagi userni statusni tekshirish
    if (status == false) {
      //userTariff Statusni tekshirish
      if (hasTariff == true) {
        _targetRoute = AppRouter.adminConnect;
      } else {
        _targetRoute = AppRouter.tariff;
      }
    } else {
      if (storeProvider.storeId == null) {
          // Store tanlanmagan bo‘lsa → StoreSelectPage
        _targetRoute = AppRouter.company;
       
      } else {
       // Store tanlangan bo‘lsa → HomePage
        _targetRoute = AppRouter.home;
      }
    }
  }
}
