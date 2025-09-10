import 'package:flutter/cupertino.dart';
import 'package:mobi_store/ui/core/ui/dropdown/currency_select_dropdown.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/dropdown/language_dropdown.dart';
import 'package:mobi_store/ui/core/ui/widget/user/user_info.dart';
import 'package:mobi_store/ui/core/ui/widget/user/user_tariff_info.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeVM = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("setting_and_account".tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: UiConstants.spacing,
          children: [
            //Account setting
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: UiConstants.spacing * 3,
              children: [
                Text(
                  "account_settings".tr,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.shadow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UserInfoWidget(),
                UserTariffWidget(),
              ],
            ),
            const SizedBox(height: 16.0),

            //App Setting
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: UiConstants.spacing,
              children: [
                Text(
                  "app_setting".tr,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.shadow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0),

                /// Dark Mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("dark_mode".tr, style: theme.textTheme.bodyMedium),
                    CupertinoSwitch(
                      value: themeVM.isDarkMode,
                      onChanged: (value) {
                        themeVM.toggleTheme();
                      },
                    ),
                  ],
                ),
                Divider(color: theme.colorScheme.outline),

                /// Language dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'language'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    LanguageDropdown(),
                  ],
                ),

                Divider(color: theme.colorScheme.outline),

                /// Currency dropdown
                CurrencyDropdown(),
                Divider(color: theme.colorScheme.outline),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('signOut'.tr),
                    IconButton(
                      onPressed: () async {
                        await context
                            .read<SelectedStoreViewModel>()
                            .clearStoreId();
                        await context.read<AuthViewModel>().signOut();
                        Navigator.pushReplacementNamed(
                            context, AppRouter.splash);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
