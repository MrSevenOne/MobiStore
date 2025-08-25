import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// 🔹 ImageKit konfiguratsiyasi
const String imageKitUploadUrl = "https://upload.imagekit.io/api/v1/files/upload";
const String imageKitPrivateKey = "private_K1xUUjspkXcLUHHdWQK2FynIYPs=";

class ImageKitService {

  /// 🔹 Umumiy rasm yuklash
  /// folderType: "phones", "accessories" va hokazo
  static Future<Map<String, dynamic>?> uploadImage({
    required File file,
    required String userId,
    required String storeId,
    required String folderType, // misol: "phones" yoki "accessories"
  }) async {
    try {
      final uri = Uri.parse(imageKitUploadUrl);
      final folderPath = "/$folderType/users/$userId/$storeId";

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String extension = file.path.split('.').last;
      final String uniqueFileName = "${timestamp}_file.$extension";

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
        debugPrint("❌ Upload error: ${response.statusCode}");
        debugPrint("Server response: $respStr");
        return null;
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
      return null;
    }
  }

  /// 🔹 Rasm o‘chirish
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
        debugPrint("✅ Rasm o‘chirildi");
        return true;
      } else {
        debugPrint("❌ Delete error: ${response.statusCode}");
        debugPrint("Server response: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
      return false;
    }
  }

  /// 🔹 Rasmni yangilash (oldFileId bilan o‘chirib, yangi rasmni yuklash)
  static Future<Map<String, dynamic>?> updateImage({
    required File newFile,
    required String userId,
    required String storeId,
    required String folderType, // "phones" yoki "accessories"
    required String oldFileId,
  }) async {
    // 1️⃣ Eski rasmni o‘chirish
    final deleted = await deleteImage(oldFileId);
    if (!deleted) {
      debugPrint("❌ Eski rasmni o‘chirishda xatolik");
      return null;
    }

    // 2️⃣ Yangi rasmni yuklash
    final uploaded = await uploadImage(
      file: newFile,
      userId: userId,
      storeId: storeId,
      folderType: folderType,
    );

    return uploaded;
  }

  /// 🔹 Safe update: avval yangi rasmni yuklaydi, keyin eski rasmni o‘chiradi
  static Future<Map<String, dynamic>?> safeUpdateImage({
    required File newFile,
    required String userId,
    required String storeId,
    required String folderType, // "phones" yoki "accessories"
    required String oldFileId,
  }) async {
    // 1️⃣ Yangi rasmni yuklash
    final uploaded = await uploadImage(
      file: newFile,
      userId: userId,
      storeId: storeId,
      folderType: folderType,
    );

    if (uploaded == null) {
      debugPrint("❌ Yangi rasm yuklanmadi");
      return null;
    }

    // 2️⃣ Eski rasmni o‘chirish
    final deleted = await deleteImage(oldFileId);
    if (!deleted) {
      debugPrint("⚠️ Yangi rasm yuklandi, lekin eski rasm o‘chmadi");
    }

    return uploaded;
  }
}
