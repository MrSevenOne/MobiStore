import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobi_store/ui/core/ui/dropdown/currency_select_dropdown.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeVM = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting & Account"),
      ),
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "App Setting",
              style: theme.textTheme.titleSmall!.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12.0),

            /// Dark Mode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode", style: theme.textTheme.bodyMedium),
                CupertinoSwitch(
                  value: themeVM.isDarkMode,
                  onChanged: (value) {
                    themeVM.toggleTheme();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Divider(color: theme.colorScheme.outline),

            /// Language dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                  child: DropdownButton<String>(
                    value: Get.locale?.languageCode ?? 'en',
                    underline: const SizedBox(),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    style: Theme.of(context).textTheme.bodyMedium,
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'uz', child: Text("O'zbekcha")),
                      DropdownMenuItem(value: 'ru', child: Text('Русский')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        Get.updateLocale(Locale(value));
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12.0),
            Divider(color: theme.colorScheme.outline),

            /// Currency dropdown
            CurrencyDropdown(),
          ],
        ),
      ),
    );
  }
}
