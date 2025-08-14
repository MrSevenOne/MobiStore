import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi_store/data/services/data/supabase/store/store_service.dart';

class StoreViewModel extends ChangeNotifier {
  final SupabaseStorageService _storageService;
  final ImagePicker _picker = ImagePicker();

  StoreViewModel(this._storageService);

  String? uploadedImageUrl;
  bool isLoading = false;
  String? errorMessage;

  /// Kamera orqali rasm tanlab yuklash
  Future<void> pickAndUploadImage(String storeId) async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.camera);
      if (picked == null) return;

      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final supabaseUrl = await _storageService.uploadStoreImage(
        file: picked,
        storeId: storeId,
      );

      if (supabaseUrl == null) {
        errorMessage = "❌ Yuklashda xatolik";
      } else {
        uploadedImageUrl = supabaseUrl;
      }
    } catch (e) {
      errorMessage = "❌ Xatolik: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Gallery orqali rasm tanlab yuklash
  Future<void> pickFromGalleryAndUpload(String storeId) async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked == null) return;

      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final supabaseUrl = await _storageService.uploadStoreImage(
        file: picked,
        storeId: storeId,
      );

      if (supabaseUrl == null) {
        errorMessage = "❌ Yuklashda xatolik";
      } else {
        uploadedImageUrl = supabaseUrl;
      }
    } catch (e) {
      errorMessage = "❌ Xatolik: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
