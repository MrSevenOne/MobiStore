import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';

class ImageUploadViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? pickedImage;
  bool isUploading = false;
  String? uploadedUrl;
  String? uploadedFileId;

  /// 📌 Rasm tanlash
  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage = File(file.path);
      uploadedUrl = null;
      uploadedFileId = null;
      notifyListeners();
    }
  }

  /// 📌 Yangi rasmni yuklash
  /// folderType: "phones" yoki "accessories" kabi
  Future<void> uploadImage({
    required String userId,
    required String storeId,
    required String folderType,
  }) async {
    if (pickedImage == null) return;

    isUploading = true;
    notifyListeners();

    final result = await ImageKitService.uploadImage(
      file: pickedImage!,
      userId: userId,
      storeId: storeId,
      folderType: folderType,
    );

    isUploading = false;

    if (result != null) {
      uploadedUrl = result['url'];
      uploadedFileId = result['fileId'];
    }

    notifyListeners();
  }

  /// 📌 Rasmni yangilash (eski rasmni o‘chirib, yangi rasm yuklash)
  Future<void> updateImage({
    required String userId,
    required String storeId,
    required String folderType,
  }) async {
    if (pickedImage == null || uploadedFileId == null) return;

    isUploading = true;
    notifyListeners();

    final result = await ImageKitService.updateImage(
      newFile: pickedImage!,
      userId: userId,
      storeId: storeId,
      folderType: folderType,
      oldFileId: uploadedFileId!,
    );

    isUploading = false;

    if (result != null) {
      uploadedUrl = result['url'];
      uploadedFileId = result['fileId'];
    }

    notifyListeners();
  }

  /// 📌 Rasmni o‘chirish
  Future<void> deleteCurrentImage() async {
    if (uploadedFileId == null) return;

    isUploading = true;
    notifyListeners();

    final deleted = await ImageKitService.deleteImage(uploadedFileId!);

    isUploading = false;

    if (deleted) {
      pickedImage = null;
      uploadedUrl = null;
      uploadedFileId = null;
    }

    notifyListeners();
  }

  /// 📌 Reset
  void reset() {
    pickedImage = null;
    uploadedUrl = null;
    uploadedFileId = null;
    isUploading = false;
    notifyListeners();
  }
}
