import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? pickedImage;
  bool isUploading = false;
  String? uploadedUrl;

  /// 📌 Rasm tanlash
  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage = File(file.path);
      uploadedUrl = null; // eski linkni tozalash
      notifyListeners();
    }
  }

  /// 📌 Rasmni yuklash (ImageKitService orqali)
  Future<void> uploadImage(String userId, String storeId) async {
    if (pickedImage == null) return;

    isUploading = true;
    notifyListeners();

    final url = await ImageKitService.uploadImage(
      file: pickedImage!,
      userId: userId,
      storeId: storeId,
    );

    isUploading = false;
    uploadedUrl = url;
    notifyListeners();
  }

  /// 📌 Reset
  void reset() {
    pickedImage = null;
    uploadedUrl = null;
    isUploading = false;
    notifyListeners();
  }
}
