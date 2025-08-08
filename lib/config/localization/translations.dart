import 'package:get/get.dart';
import 'en_us.dart';
import 'ru_ru.dart';
import 'uz_uz.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'uz_UZ': uzUZ,
        'en_US': enUS,
        'ru_RU': ruRU,
      };
}