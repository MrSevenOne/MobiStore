import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: theme.textTheme.bodyMedium,
                ),
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
            // Language dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Theme bilan rang moslashadi
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface, // Theme surface rangi
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                  child: DropdownButton<String>(
                    value: Get.locale?.languageCode ?? 'en',
                    underline:
                        const SizedBox(), // default underline yo‘q qiladi
                    dropdownColor:
                        Theme.of(context).colorScheme.surface, // dropdown rang
                    style: Theme.of(context).textTheme.bodyMedium, // text style
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'uz', child: Text("O'zbekcha")),
                      DropdownMenuItem(value: 'ru', child: Text('Русский')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        Get.updateLocale(
                            Locale(value)); // tilni darhol o‘zgartiradi
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            // Matnlarni chiqarish (.tr ishlaydi)
            Text('sign_in'.tr, style: const TextStyle(fontSize: 20)),
            Text('home_title'.tr, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
