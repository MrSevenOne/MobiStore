import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';
import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/phones/widgets/phone_edit.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';

class OptionsPhoneShowWidget extends StatelessWidget {
  final PhoneModel phoneModel;
  const OptionsPhoneShowWidget({super.key, required this.phoneModel});

  static Future<bool?> show(BuildContext context, PhoneModel phoneModel) async {
    return showDialog<bool>(
      context: context,
      builder: (_) => OptionsPhoneShowWidget(phoneModel: phoneModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phoneViewModel = context.watch<PhoneViewModel>();

    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        "${phoneModel.companyModel?.name} ${phoneModel.modelName}",
        style: theme.textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Delete tugmasi
          GestureDetector(
            onTap: () async {
              try {
                // Agar rasm fileId mavjud bo'lsa, rasmni o'chiramiz
                if (phoneModel.fileId != null &&
                    phoneModel.fileId!.isNotEmpty) {
                  await ImageKitService.deleteImage(phoneModel.fileId!);
                }

                // Agar telefon id mavjud bo'lsa, telefonni o'chiramiz
                if (phoneModel.id != null) {
                  await phoneViewModel.deletePhone(phoneModel.id!);
                }

                Navigator.of(context)
                    .pop(true); // dialog yopiladi va true qaytadi
              } catch (e) {
                debugPrint("Delete Error: $e");
              } finally {
                debugPrint("rasm va telefon malumot ochirildi: true");
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
              // Edit funksiyasini shu yerga qo‘shish mumkin
              PhoneEditWidget.show(context, phoneModel);
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
