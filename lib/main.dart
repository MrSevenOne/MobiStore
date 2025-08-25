import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobi_store/config/localization/translations.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/themes/dark_theme.dart';
import 'package:mobi_store/ui/core/themes/light_theme.dart';
import 'package:mobi_store/ui/provider/accessory_category_viewmodel.dart';
import 'package:mobi_store/ui/provider/accessory_report_viewmodel.dart';
import 'package:mobi_store/ui/provider/accessory_viewmodel.dart';
import 'package:mobi_store/ui/provider/company_viewmodel.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';
import 'package:mobi_store/ui/provider/imageupload_viewmodel.dart';
import 'package:mobi_store/ui/provider/locale_viewmodel.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/provider/theme_provider.dart';
import 'package:mobi_store/ui/provider/user_provider.dart';
import 'package:mobi_store/ui/splash/view_model/splash_view_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );

  // Endi UserManager ishlatish xavfsiz
  final userId = UserManager.currentUserId;
  debugPrint('Xozirgi User Idsi: $userId');

  // 📥 Saqlangan ID ni yuklaymiz
  final storeVM = SelectedStoreViewModel();
  await storeVM.loadStoreId();
  debugPrint("📌 Saqlangan storeId: ${storeVM.storeId}");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocaleViewmodel(),
        ),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => SplashViewModel()),
        ChangeNotifierProvider(
          create: (_) => TariffViewModel(),
        ),
        ChangeNotifierProvider(create: (_) => UserTariffViewModel()),
        ChangeNotifierProvider(create: (_) => SelectedStoreViewModel()),
        ChangeNotifierProvider(create: (_) => ShopViewmodel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel(UserService())),
        ChangeNotifierProvider(create: (_) => CompanyViewModel()),
        ChangeNotifierProvider(create: (_) => PhoneViewModel()),
        ChangeNotifierProvider(create: (_) => ImageUploadViewModel()),
        ChangeNotifierProvider(create: (_) => PhoneReportViewModel()),
        ChangeNotifierProvider(create: (_) => DaterangeViewmodel()),
        ChangeNotifierProvider(create: (_) => AccessoryCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => AccessoryViewModel()),
        ChangeNotifierProvider(create: (_) => AccessoryReportViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleViewmodel>(context);
    final themeVM = Provider.of<ThemeViewModel>(context);

    return GetMaterialApp(
      // home: CustomBottomNavBar(),
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: localeProvider.locale,
      fallbackLocale: const Locale('en', 'US'),
      theme: LightTheme,
      darkTheme: DarkTheme,
      themeMode: themeVM.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRouter.splash,
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
