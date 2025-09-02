import 'package:get/get.dart';
import 'en_us.dart';
import 'uz_uz.dart';
import 'ru_ru.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'uz': uzUZ,
        'ru': ruRU,
      };
}
