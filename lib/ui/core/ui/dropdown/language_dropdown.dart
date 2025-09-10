import 'package:get/get.dart';
import 'package:mobi_store/export.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: Get.locale?.languageCode ?? 'en',
        underline: const SizedBox(),
        dropdownColor: theme.colorScheme.secondary,
        style: Theme.of(context).textTheme.bodyMedium,
        items: const [
          DropdownMenuItem(value: 'en', child: Text('EN')),
          DropdownMenuItem(value: 'uz', child: Text("UZ")),
          DropdownMenuItem(value: 'ru', child: Text('RU')),
          DropdownMenuItem(value: 'ky', child: Text("KY")),
          DropdownMenuItem(value: 'tj', child: Text('TJ')),
          DropdownMenuItem(value: 'de', child: Text("DE")),
          DropdownMenuItem(value: 'kk', child: Text('KZ')),
        ],
        onChanged: (value) {
          if (value != null) {
            Get.updateLocale(Locale(value));
          }
        },
      ),
    );
  }
}
