import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';

class ImageUploadWidget extends StatefulWidget {
  final String userId;
  final String storeId;
  final Function(String imageUrl) onImageUploaded;

  const ImageUploadWidget({
    super.key,
    required this.userId,
    required this.storeId,
    required this.onImageUploaded,
  });

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  bool isUploading = false;
  String? uploadedUrl;

  Future<void> _pickAndUploadImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      pickedImage = File(file.path);
      isUploading = true;
    });

    final imageUrl = await ImageKitService.uploadImage(
      file: pickedImage!,
      userId: widget.userId,
      storeId: widget.storeId,
    );

    setState(() {
      isUploading = false;
      uploadedUrl = imageUrl;
    });

    if (imageUrl != null) {
      widget.onImageUploaded(imageUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rasm yuklashda xatolik yuz berdi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUploading ? null : _pickAndUploadImage,
      child: Container(
        height: 150,
        width: double.infinity,
        color: Colors.grey[200],
        child: isUploading
            ? const Center(child: CircularProgressIndicator())
            : uploadedUrl != null
                ? Image.network(uploadedUrl!, fit: BoxFit.cover)
                : pickedImage != null
                    ? Image.file(pickedImage!, fit: BoxFit.cover)
                    : const Icon(Icons.add_a_photo, size: 50),
      ),
    );
  }
}
