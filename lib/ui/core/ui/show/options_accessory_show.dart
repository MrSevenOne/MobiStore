import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/accessoryedit_show.dart';
import 'package:mobi_store/ui/core/ui/show/delete_show.dart';
import 'package:mobi_store/ui/provider/accessory_viewmodel.dart';

class OptionsAccessoryShowWidget extends StatelessWidget {
  final AccessoryModel accessoryModel;
  const OptionsAccessoryShowWidget({super.key, required this.accessoryModel});

  static Future<bool?> show(
      BuildContext context, AccessoryModel accessoryModel) async {
    return showDialog<bool>(
      context: context,
      builder: (_) =>
          OptionsAccessoryShowWidget(accessoryModel: accessoryModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accessoryVM = context.watch<AccessoryViewModel>();

    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        accessoryModel.name,
        style: theme.textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Delete tugmasi
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              try {
                // Agar rasm fileId mavjud bo'lsa, rasmni o'chiramiz
                if (accessoryModel.fileId != null &&
                    accessoryModel.fileId!.isNotEmpty) {
                  await ImageKitService.deleteImage(accessoryModel.fileId!);
                }

                // O'chirishni tasdiqlash uchun dialog
                await DeleteDialog.show(
                  context: context,
                  onConfirm: () async {
                    if (accessoryModel.id != null) {
                      await accessoryVM.deleteAccessory(accessoryModel.id!);
                    }
                  },
                  title: "delete_accessory".tr,
                  description: "are_you_sure_delete_accessory".tr,
                );
              } catch (e) {
                debugPrint("Delete Error: $e");
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("delete".tr, style: theme.textTheme.bodyLarge),
                  Icon(Icons.delete,
                      color: theme.colorScheme.error, size: 20.0),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ✏️ Edit tugmasi
          GestureDetector(
            onTap: () {
              AccessoryEditWidget.show(context, accessoryModel);
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("edit".tr, style: theme.textTheme.bodyLarge),
                  Icon(Icons.edit,
                      color: theme.colorScheme.primary, size: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
