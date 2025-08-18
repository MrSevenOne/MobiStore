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
  static Future<Map<String, dynamic>?> uploadImage({
    required File file,
    required String userId,
    required String storeId,
  }) async {
    try {
      final uri = Uri.parse(imageKitUploadUrl);

      final folderPath = "/phones/users/$userId/$storeId";

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = file.path.split('.').last;
      final String uniqueFileName = "${timestamp}_phone.$extension";

      final request = http.MultipartRequest('POST', uri)
        ..fields['fileName'] = uniqueFileName
        ..fields['folder'] = folderPath
        ..files.add(await http.MultipartFile.fromPath('file', file.path))
        ..headers['Authorization'] =
            'Basic ${base64Encode(utf8.encode("$imageKitPrivateKey:"))}';

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = json.decode(respStr);
        return {
          "url": data['url'],
          "fileId": data['fileId'],
        };
      } else {
        print("❌ Upload error: ${response.statusCode}");
        print("Server javobi: $respStr");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }

  /// Rasmni o‘chirish
  static Future<bool> deleteImage(String fileId) async {
    try {
      final uri = Uri.parse("https://api.imagekit.io/v1/files/$fileId");

      final response = await http.delete(
        uri,
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode("$imageKitPrivateKey:"))}',
        },
      );

      if (response.statusCode == 204) {
        print("✅ Rasm o‘chirildi");
        return true;
      } else {
        print("❌ Delete error: ${response.statusCode}");
        print("Server javobi: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return false;
    }
  }

  /// Rasmni yangilash (oldFileId bilan o‘chirib, yangi rasmni yuklash)
  static Future<Map<String, dynamic>?> updateImage({
    required File newFile,
    required String userId,
    required String storeId,
    required String oldFileId,
  }) async {
    // 1️⃣ Avval eski rasmni o‘chirish
    final deleted = await deleteImage(oldFileId);

    if (!deleted) {
      print("❌ Eski rasmni o‘chirishda xatolik");
      return null;
    }

    // 2️⃣ Yangi rasmni yuklash
    final uploaded = await uploadImage(
      file: newFile,
      userId: userId,
      storeId: storeId,
    );

    return uploaded;
  }
}
