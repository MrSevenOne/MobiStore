import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/imageupload_viewmodel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageUploadWidget extends StatelessWidget {
  final String userId;
  final String storeId;
  final String folderType; // "phones" yoki "accessories"
  final Function(String imageUrl, String fileId) onImageUploaded;
  final String? initialImageUrl;

  const ImageUploadWidget({
    super.key,
    required this.userId,
    required this.storeId,
    required this.folderType,
    required this.onImageUploaded,
    this.initialImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageUploadViewModel>(
      create: (_) => ImageUploadViewModel(),
      child: Consumer<ImageUploadViewModel>(
        builder: (context, vm, _) {
          final displayImage =
              vm.uploadedUrl ?? (vm.pickedImage != null ? (kIsWeb ? '' : vm.pickedImage!.path) : initialImageUrl);

          return GestureDetector(
            onTap: vm.isUploading
                ? null
                : () async {
                    await vm.pickImage();
                    if (vm.pickedImage != null) {
                      await vm.uploadImage(
                        userId: userId,
                        storeId: storeId,
                        folderType: folderType,
                      );
                      if (vm.uploadedUrl != null && vm.uploadedFileId != null) {
                        onImageUploaded(vm.uploadedUrl!, vm.uploadedFileId!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("image_upload_error".tr),
                          ),
                        );
                      }
                    }
                  },
            child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(12),
              ),
              child: vm.isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : displayImage != null
                      ? (vm.pickedImage != null
                          ? (kIsWeb
                              ? FutureBuilder<Widget>(
                                  future: vm.pickedImage!.readAsBytes().then((bytes) => Image.memory(bytes, fit: BoxFit.cover)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                      return snapshot.data!;
                                    }
                                    return const SizedBox.shrink();
                                  },
                                )
                              : Image.file(File(vm.pickedImage!.path), fit: BoxFit.cover))
                          : Image.network(displayImage, fit: BoxFit.cover))
                      : Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ),
            ),
          );
        },
      ),
    );
  }
}