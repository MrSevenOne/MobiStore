import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/auth/admin_connect_screen.dart';
import 'package:mobi_store/ui/auth/login_screen.dart';
import 'package:mobi_store/ui/auth/signup_screen.dart';
import 'package:mobi_store/ui/home/home_screen.dart';
import 'package:mobi_store/ui/onboarding/onboarding_screen.dart';
import 'package:mobi_store/ui/profile/profile_screen.dart';
import 'package:mobi_store/ui/setting/widgets/setting_screen.dart';
import 'package:mobi_store/ui/shop/shop_screen.dart';
import 'package:mobi_store/ui/splash/view_model/splash_view_model.dart';
import 'package:mobi_store/ui/splash/widgets/splash_screen.dart';
import 'package:mobi_store/ui/tariff/tariff_screen.dart';

class AppRouter {
  static const String splash = "/SplashScreen";
  static const String onboarding = '/OnboardingScreen';
  static const String login = '/LoginScreen';
  static const String signup = '/SignUpScreen';
  static const String shop = '/ShopScreen';
  static const String home = '/HomeScreen';
  static const String tariff = '/TariffScreen';
  static const String adminConnect = '/AdminConnectScreen';
  static const String profile = '/ProfileScreen';
  static const String setting = '/SettingScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            viewModel: arg is SplashViewModel ? arg : SplashViewModel(),
          ),
        );

      case onboarding:
        return MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        );

      case login:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // bottom to top
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );

      case signup:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // bottom to top
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );

      case shop:
        // final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ShopScreen(),
        );

      //Admin Connect Page
      case adminConnect:
        return MaterialPageRoute(
          builder: (context) => AdminConnectScreen(),
        );
      case tariff:
        // final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => TariffScreen(),
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
          ),
        );
      case home:
        // final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
              // viewModel: arg is HomeViewModel ? arg : HomeViewModel(),
              ),
        );
      case setting:
        // final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => SettingScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("Route not found: ${settings.name}"),
            ),
          ),
        );
    }
  }
}
