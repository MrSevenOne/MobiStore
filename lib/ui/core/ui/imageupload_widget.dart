import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/imageupload_viewmodel.dart';

class ImageUploadWidget extends StatelessWidget {
  final String userId;
  final String storeId;
  final String folderType; // "phones" yoki "accessories"
  final Function(String imageUrl, String fileId) onImageUploaded;

  /// 🔹 Eski rasmni ko‘rsatish uchun
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
          final displayImage = vm.uploadedUrl ?? vm.pickedImage?.path ?? initialImageUrl;

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
                          const SnackBar(
                            content: Text("Rasm yuklashda xatolik yuz berdi"),
                          ),
                        );
                      }
                    }
                  },
            child: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: vm.isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : displayImage != null
                      ? (vm.pickedImage != null
                          ? Image.file(vm.pickedImage!, fit: BoxFit.cover)
                          : Image.network(displayImage, fit: BoxFit.cover))
                      : const Icon(Icons.add_a_photo, size: 50),
            ),
          );
        },
      ),
    );
  }
}
