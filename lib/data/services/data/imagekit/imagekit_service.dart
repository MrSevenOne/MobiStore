import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// 🔹 ImageKit konfiguratsiyasi
const String imageKitBaseUrl = "https://ik.imagekit.io/sevenone";
const String imageKitUploadUrl = "https://upload.imagekit.io/api/v1/files/upload";
const String imageKitPrivateKey = "private_K1xUUjspkXcLUHHdWQK2FynIYPs=";

/// Service: ImageKit bilan ishlash
class ImageKitService {
  /// Rasm yuklash
  static Future<String?> uploadImage({
    required File file,
    required String userId,
    required String storeId,
  }) async {
    try {
      final uri = Uri.parse(imageKitUploadUrl);

      // 📂 Dinamik folder yo‘li
      final folderPath = "/phones/users/$userId/$storeId";

      // 📌 Fayl nomini vaqt bo‘yicha yaratish
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = file.path.split('.').last; // jpg, png va h.k.
      final String uniqueFileName = "${timestamp}_phone.$extension";

      final request = http.MultipartRequest('POST', uri)
        ..fields['fileName'] = uniqueFileName
        ..fields['folder'] = folderPath
        ..files.add(await http.MultipartFile.fromPath('file', file.path))
        ..headers['Authorization'] =
            'Basic ' + base64Encode(utf8.encode("$imageKitPrivateKey:"));

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        return data['url']; // ✅ Yuklangan rasm manzili
      } else {
        final respStr = await response.stream.bytesToString();
        print("❌ Upload error: ${response.statusCode}");
        print("Server javobi: $respStr");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
}
