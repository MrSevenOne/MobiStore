import 'package:mobi_store/data/services/data/imagekit/imagekit_service.dart';
import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/dropdown/colour_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/company_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/memory_dropdown.dart';
import 'package:mobi_store/ui/core/ui/textfield/custom_textfield.dart';
import 'package:mobi_store/ui/phones/widgets/imageupload_widget.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class PhoneEditWidget extends StatefulWidget {
  final PhoneModel phone;

  const PhoneEditWidget({super.key, required this.phone});

  @override
  State<PhoneEditWidget> createState() => _PhoneEditWidgetState();

  static Future<void> show(BuildContext context, PhoneModel phone) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PhoneEditWidget(phone: phone),
    );
  }
}

class _PhoneEditWidgetState extends State<PhoneEditWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController modelController;
  late TextEditingController colourController;
  late TextEditingController yomkistController;
  late TextEditingController buyPriceController;
  late TextEditingController ramController;
  late TextEditingController costPriceController;

  String? selectedCompanyId;
  int? selectedMemory;
  int imeiCount = 0;
  String statusValue = "Yangi";
  bool boxValue = true;

  bool isLoading = false;

  /// 🔹 Eski va yangi rasm ma’lumotlari
  String? uploadedImageUrl;
  String? uploadedFileId;

  @override
  void initState() {
    super.initState();
    final phone = widget.phone;
    modelController = TextEditingController(text: phone.modelName);
    colourController = TextEditingController(text: phone.colour);
    yomkistController = TextEditingController(text: phone.yomkist?.toString());
    buyPriceController = TextEditingController(text: phone.buyPrice.toString());
    ramController = TextEditingController(text: phone.ram?.toString());
    costPriceController =
        TextEditingController(text: phone.CostPrice.toString());

    selectedCompanyId = phone.companyName;
    selectedMemory = phone.memory;
    imeiCount = phone.imei;
    statusValue = phone.status;
    boxValue = phone.box;

    uploadedImageUrl = phone.imageUrl;
    uploadedFileId = phone.fileId;
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (uploadedImageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("upload_image_warning".tr)),
      );
      return;
    }

    if (selectedCompanyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("select_company_warning".tr)),
      );
      return;
    }

    setState(() => isLoading = true);

    final storeVM = Provider.of<SelectedStoreViewModel>(context, listen: false);
    final shopId = storeVM.storeId?.toString();
    final userId = UserManager.currentUserId;

    if (userId == null || shopId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("user_or_store_not_selected".tr)),
      );
      setState(() => isLoading = false);
      return;
    }

    // 🔹 Yangi qiymatlar
    int? yomkist;
    if (yomkistController.text.trim().isNotEmpty) {
      yomkist = int.tryParse(yomkistController.text.trim());
    }

    int? ram;
    if (ramController.text.trim().isNotEmpty) {
      ram = int.tryParse(ramController.text.trim());
    }

    // 🔹 Yangilangan telefon modelini yaratish
    final updatedPhone = PhoneModel(
      id: widget.phone.id,
      modelName: modelController.text.trim(),
      colour: colourController.text.trim().isNotEmpty
          ? colourController.text.trim()
          : null,
      yomkist: yomkist,
      status: statusValue,
      box: boxValue,
      imei: imeiCount,
      buyPrice: double.tryParse(buyPriceController.text.trim()) ?? 0,
      CostPrice: double.tryParse(costPriceController.text.trim()) ?? 0,
      userId: userId,
      shopId: shopId,
      imageUrl: uploadedImageUrl!, // 🔹 yangilangan yoki eski rasm
      fileId: uploadedFileId,
      companyName: selectedCompanyId!,
      memory: selectedMemory ?? 64,
      ram: ram,
      createdAt: widget.phone.createdAt,
      companyModel: widget.phone.companyModel,
    );

    final phoneVM = Provider.of<PhoneViewModel>(context, listen: false);
    final result = await phoneVM.updatePhone(updatedPhone);

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("phone_updated_success".tr)),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(phoneVM.errorMessage ?? "phone_update_false".tr)),
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

    if (userId == null || storeVM.storeId == null) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Error: User or store not selected".tr),
        ),
      );
    }

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
                    "edit_phone".tr,
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.colorScheme.onSecondary),
                  ),

                  /// 🔹 Rasm yuklash/yangilash
                  ImageUploadWidget(
                    userId: userId,
                    storeId: storeVM.storeId.toString(),
                    initialImageUrl: uploadedImageUrl, // eski rasm ko‘rinadi
                    onImageUploaded: (url, fileId) async {
                      // Agar eski fayl bor bo‘lsa, o‘chirib yuborish
                      if (uploadedFileId != null && uploadedFileId != fileId) {
                        await ImageKitService.deleteImage(uploadedFileId!);
                      }
                      setState(() {
                        uploadedImageUrl = url;
                        uploadedFileId = fileId;
                      });
                    },
                  ),

                  CompanyDropdown(
                    selectedCompanyId: selectedCompanyId,
                    onChanged: (value) =>
                        setState(() => selectedCompanyId = value),
                  ),

                  CustomTextfield(
                    label: 'mobile_name'.tr,
                    hint: 'enter_model'.tr,
                    controller: modelController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_model'.tr
                        : null,
                  ),

                  ColourDropdown(controller: colourController),

                  MemoryDropdownWidget(
                    selectedMemory: selectedMemory,
                    onChanged: (val) => setState(() => selectedMemory = val),
                  ),
                  //Buy Price 
                  CustomTextfield(
                    label: 'Buy Price',
                    hint: 'enter_price'.tr,
                    controller: buyPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_price'.tr
                        : null,
                  ),
                  //Cost Price
                   CustomTextfield(
                    label: 'Buy Price',
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
