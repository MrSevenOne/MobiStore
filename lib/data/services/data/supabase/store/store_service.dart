import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _supabase;
  final String bucketName = 'phone_images';

  SupabaseStorageService(this._supabase);

  /// Rasmni platformaga qarab siqish
  Future<Uint8List?> _compressImage(Uint8List bytes) async {
    if (kIsWeb) {
      // Web — pure Dart siqish
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return null;
      return Uint8List.fromList(
        img.encodeJpg(decoded, quality: 80),
      );
    } else {
      // Mobile — flutter_image_compress
      return await FlutterImageCompress.compressWithList(
        bytes,
        quality: 80,
        format: CompressFormat.jpeg,
      );
    }
  }

  /// Rasm yuklash (user_id + storeName bo‘yicha papkaga)
  Future<String?> uploadStoreImage({
    required XFile file,
    required String storeId,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        debugPrint("❌ User login qilmagan");
        return null;
      }

      final fileBytes = await file.readAsBytes();

      // Rasmni siqish
      final compressedBytes = await _compressImage(fileBytes);
      if (compressedBytes == null) {
        debugPrint("❌ Siqishda xatolik");
        return null;
      }

      // Fayl nomi
      final fileName = "$userId/$storeId/${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Supabase Storage’ga yuklash
      final result = await _supabase.storage
          .from(bucketName)
          .uploadBinary(fileName, compressedBytes, fileOptions: const FileOptions(upsert: false));

      if (result != null) {
        return _supabase.storage.from(bucketName).getPublicUrl(fileName);
      }
      return null;
    } catch (e) {
      debugPrint("❌ Supabase upload error: $e");
      return null;
    }
  }
}
