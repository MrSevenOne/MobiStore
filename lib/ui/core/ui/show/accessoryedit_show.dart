import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/dropdown/colour_dropdown.dart';
import 'package:mobi_store/ui/core/ui/textfield/currency_textcontroller.dart';
import 'package:mobi_store/ui/core/ui/textfield/custom_textfield.dart';
import 'package:mobi_store/ui/core/ui/imageupload_widget.dart';
import 'package:mobi_store/ui/provider/accessory_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';

class AccessoryEditWidget extends StatefulWidget {
  final AccessoryModel accessory;

  const AccessoryEditWidget({super.key, required this.accessory});

  @override
  State<AccessoryEditWidget> createState() => _AccessoryEditWidgetState();

  static Future<void> show(BuildContext context, AccessoryModel accessory) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AccessoryEditWidget(accessory: accessory),
    );
  }
}

class _AccessoryEditWidgetState extends State<AccessoryEditWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController brandController;
  late TextEditingController colourController;
  late CurrencyTextController buyPriceController;
  late CurrencyTextController costPriceController;
  late TextEditingController quantityController;

  bool isLoading = false;

  /// 🔹 Eski va yangi rasm ma’lumotlari
  String? uploadedImageUrl;
  String? uploadedFileId;

  @override
  void initState() {
    super.initState();
    final accessory = widget.accessory;
    nameController = TextEditingController(text: accessory.name);
    brandController = TextEditingController(text: accessory.brand ?? '');
    colourController = TextEditingController(text: accessory.colour ?? '');
    buyPriceController = CurrencyTextController();
    costPriceController = CurrencyTextController();
    quantityController =
        TextEditingController(text: accessory.quantity.toString());

    uploadedImageUrl = accessory.imageUrl;
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final storeVM = Provider.of<SelectedStoreViewModel>(context, listen: false);
    final shopId = storeVM.storeId?.toString();
    final userId = UserManager.currentUserId;
    final currencyVM = Provider.of<CurrencyViewModel>(context, listen: false);

    if (userId == null || shopId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("user_or_store_not_selected".tr)),
      );
      setState(() => isLoading = false);
      return;
    }

    // 🔹 Kiritilgan qiymatlarni UZSga konvert qilish
    double buyPriceUzs = currencyVM.toUzsNumeric(
      double.tryParse(buyPriceController.text
              .trim()
              .replaceAll(RegExp(r'[^\d.]'), '')) ??
          0,
    );
    double costPriceUzs = currencyVM.toUzsNumeric(
      double.tryParse(costPriceController.text
              .trim()
              .replaceAll(RegExp(r'[^\d.]'), '')) ??
          0,
    );
    int quantity = int.tryParse(quantityController.text.trim()) ?? 0;

    final updatedAccessory = AccessoryModel(
      categoryId: widget.accessory.categoryId,
      id: widget.accessory.id,
      name: nameController.text.trim(),
      brand: brandController.text.trim().isNotEmpty
          ? brandController.text.trim()
          : null,
      colour: colourController.text.trim().isNotEmpty
          ? colourController.text.trim()
          : null,
      buyPrice: buyPriceUzs,
      costPrice: costPriceUzs,
      quantity: quantity,
      imageUrl: uploadedImageUrl,
      userId: userId,
      createdAt: widget.accessory.createdAt,
      storeId: widget.accessory.storeId,
    );

    final accessoryVM = Provider.of<AccessoryViewModel>(context, listen: false);
    final result = await accessoryVM.updateAccessory(
        widget.accessory.id!, updatedAccessory.toJson());

    if (result) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("accessory_updated_success".tr)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(accessoryVM.errorMessage ?? "accessory_update_false".tr)),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.8;
    final storeVM = Provider.of<SelectedStoreViewModel>(context);
    final userId = UserManager.currentUserId;
    final currencyVM = Provider.of<CurrencyViewModel>(context);

    if (userId == null || storeVM.storeId == null) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("user_or_store_not_selected".tr),
        ),
      );
    }

    // 🔹 Bazadan kelgan UZS qiymatni tanlangan valyutaga konvert qilish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (buyPriceController.text.isEmpty) {
        buyPriceController.text =
            currencyVM.formatFromUzs(widget.accessory.buyPrice);
      }
      if (costPriceController.text.isEmpty) {
        costPriceController.text =
            currencyVM.formatFromUzs(widget.accessory.costPrice);
      }
    });

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 8.0,
                children: [
                  Text(
                    "edit_accessory".tr,
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                  ImageUploadWidget(
                    userId: userId,
                    storeId: storeVM.storeId.toString(),
                    initialImageUrl: uploadedImageUrl,
                    onImageUploaded: (url, fileId) async {
                      if (uploadedFileId != null && uploadedFileId != fileId) {
                        await ImageKitService.deleteImage(uploadedFileId!);
                      }
                      setState(() {
                        uploadedImageUrl = url;
                        uploadedFileId = fileId;
                      });
                    },
                    folderType: 'accessories',
                  ),
                  CustomTextfield(
                    label: 'name'.tr,
                    hint: 'enter_name'.tr,
                    controller: nameController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'enter_name'.tr : null,
                  ),
                  CustomTextfield(
                    label: 'brand'.tr,
                    hint: 'enter_brand'.tr,
                    controller: brandController,
                  ),
                  ColourDropdown(controller: colourController),
                  CustomTextfield(
                    label: 'quantity'.tr,
                    hint: 'enter_quantity'.tr,
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_quantity'.tr
                        : null,
                  ),
                  CustomTextfield(
                    label: 'buy_price'.tr,
                    hint: 'enter_price'.tr,
                    controller: buyPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_price'.tr
                        : null,
                  ),
                  CustomTextfield(
                    label: 'cost_price'.tr,
                    hint: 'enter_price'.tr,
                    controller: costPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_price'.tr
                        : null,
                  ),
                  const SizedBox(height: 16),
                  DialogButtons(
                    onCancel: () => Navigator.of(context).pop(),
                    onSubmit: submit,
                    isLoading: isLoading,
                    cancelText: "cancel".tr,
                    submitText: "update".tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
