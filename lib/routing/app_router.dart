import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/auth/widgets/admin_connect_screen.dart';
import 'package:mobi_store/ui/auth/widgets/login_screen.dart';
import 'package:mobi_store/ui/auth/widgets/signup_screen.dart';
import 'package:mobi_store/ui/store/view_model/store_view_model.dart';
import 'package:mobi_store/ui/store/store_screen.dart';
import 'package:mobi_store/ui/home/view_model/home_view_model.dart';
import 'package:mobi_store/ui/home/widgets/home_screen.dart';
import 'package:mobi_store/ui/onboarding/widgets/onboarding_screen.dart';
import 'package:mobi_store/ui/splash/view_model/splash_view_model.dart';
import 'package:mobi_store/ui/splash/widgets/splash_screen.dart';
import 'package:mobi_store/ui/tariff/view_model/tariff_view_model.dart';
import 'package:mobi_store/ui/tariff/tariff_screen.dart';

class AppRouter {
  static const String splash = "/SplashScreen";
  static const String onboarding = '/OnboardingScreen';
  static const String login = '/LoginScreen';
  static const String signup = '/SignUpScreen';
  static const String company = '/CompanyScreen';
  static const String home = '/HomeScreen';
  static const String tariff = '/TariffScreen';
  static const String adminConnect = '/AdminConnectScreen';

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

      case company:
        // final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => CompanyScreen(
          ),
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
      case home:
        final arg = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            viewModel: arg is HomeViewModel ? arg : HomeViewModel(),
          ),
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
