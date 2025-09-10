import 'package:get/get.dart';
import 'de_De.dart';
import 'en_us.dart';
import 'kk_KZ.dart';
import 'ky_Ky.dart';
import 'tj_Tj.dart';
import 'uz_uz.dart';
import 'ru_ru.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUS,
        'uz': uzUZ,
        'ru': ruRU,
        'ky': kyKY,
        'tj': tjTJ,
        'de': deDE,
        'kk': kkKZ,
      };
}
