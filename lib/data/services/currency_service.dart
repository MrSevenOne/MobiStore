import 'dart:convert';
import 'package:mobi_store/domain/models/currency_model.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  final _baseUrl = 'https://cbu.uz/uz/arkhiv-kursov-valyut/json/';

  Future<List<CurrencyModel>> fetchCurrencies() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
    );

    if (response.statusCode != 200) {
      throw Exception('Valyuta ma\'lumotlarini olishda xato');
    }

    final List<dynamic> data = json.decode(response.body);

    List<CurrencyModel> currencies =
        data.map((e) => CurrencyModel.fromJson(e)).toList();

    // 🔑 UZS ni qo‘shib qo‘yish
    currencies.insert(
      0,
      CurrencyModel(
        id: 0, // API dan kelmaydi, default 0 qo‘ydik
        code: "860", // UZS kod (masalan: ISO num code)
        ccy: "UZS",
        nameRu: "Узбекский сум",
        nameUz: "O‘zbekiston so‘mi",
        nameUzc: "Ўзбекистон сўми",
        nameEn: "Uzbekistan Som",
        nominal: 1,
        rate: 1.0,
        diff: 0.0,
        date: DateTime.now(), // Hozirgi sana qo‘yildi
      ),
    );

    return currencies;
  }

  /// Faqat valyuta kurslarini Map tarzida qaytarish
  Future<Map<String, double>> fetchRatesMap() async {
    final currencies = await fetchCurrencies();
    return {for (var item in currencies) item.code: item.rate};
  }
}
