
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobi_store/config/localization/translations.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/routing/app_router.dart';
import 'package:mobi_store/ui/core/themes/light_theme.dart';
import 'package:mobi_store/ui/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> LocaleProvider(),),
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        final localeProvider = Provider.of<LocaleProvider>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: localeProvider.locale,
      fallbackLocale: const Locale('en', 'US'),
      theme: LightTheme,
      initialRoute: AppRouter.login,
        onGenerateRoute: AppRouter.onGenerateRoute,
         builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}

