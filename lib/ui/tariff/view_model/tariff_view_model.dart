import 'package:mobi_store/export.dart';

class TariffViewModel extends ChangeNotifier {
  final TariffService _service = TariffService();

  List<TariffModel> tariffs = [];
  TariffModel? selectedTariff;
  bool isLoading = false;
  String? errorMessage;

  /// Barcha tariflarni yuklash
  Future<void> fetchTariffs() async {
    _setLoading(true);
    try {
      tariffs = await _service.getAllTariffs();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Tariflarni yuklashda xatolik yuz berdi';
    }
    _setLoading(false);
  }

  /// ID orqali bitta tarifni olish
  Future<void> getTariffById(String id) async {
    _setLoading(true);
    try {
      selectedTariff = await _service.getTariffById(id);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Tarifni olishda xatolik yuz berdi';
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
