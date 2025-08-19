import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/checkbox/checkbox_widget.dart';
import 'package:mobi_store/ui/core/ui/dropdown/colour_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/company_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/imei_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/memory_dropdown.dart';
import 'package:mobi_store/ui/core/ui/snack_bar/snackbar_widget.dart';
import 'package:mobi_store/ui/core/ui/textfield/custom_textfield.dart';
import 'package:mobi_store/ui/phones/widgets/imageupload_widget.dart';
import 'package:mobi_store/ui/provider/company_viewmodel.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class PhoneAddPage extends StatefulWidget {
  const PhoneAddPage({super.key});

  @override
  State<PhoneAddPage> createState() => _PhoneAddPageState();
}

class _PhoneAddPageState extends State<PhoneAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colourController = TextEditingController();
  final TextEditingController yomkistController = TextEditingController();
  final TextEditingController imeiController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ramController = TextEditingController();

  String? selectedCompanyId;
  int? selectedMemory;
  int imeiCount = 0;
  String statusValue = "Yangi";
  bool boxValue = true;
  bool isLoading = false;
  String? uploadedImageUrl;
  String? uploadedFileId;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedCompanyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("select_company_warning".tr)),
      );
      return;
    }

    setState(() => isLoading = true);

    final storeVM = Provider.of<SelectedStoreViewModel>(context, listen: false);
    final shopId = storeVM.storeId?.toString() ?? "bosh";

    final phone = PhoneModel(
      modelName: modelController.text.trim(),
      colour: colourController.text.trim(),
      yomkist: int.tryParse(yomkistController.text.trim()),
      status: statusValue,
      box: boxValue,
      imei: imeiCount,
      price: double.tryParse(priceController.text.trim()) ?? 0,
      companyName: selectedCompanyId!,
      shopId: shopId,
      imageUrl: uploadedImageUrl,
      fileId: uploadedFileId,
      memory: selectedMemory ?? 64,
      ram: ramController.text.trim().isEmpty
          ? 0
          : int.tryParse(ramController.text.trim()) ?? 0,
    );

    final phoneVM = Provider.of<PhoneViewModel>(context, listen: false);
    final result = await phoneVM.addPhone(phone);

    if (result != null) {
      SnackBarWidget.showSuccess("phone_add_true".tr, 'phone_added_success'.tr);

      // ✅ HomePage ga qaytarish
      Navigator.pushNamed(context, AppRouter.home);
    } else {
      SnackBarWidget.showError("phone_add_false".tr, 'phone_added_error'.tr);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final storeVM = Provider.of<SelectedStoreViewModel>(context);
    final userId = UserManager.currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text("add_phone".tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8.0,
            children: [
              /// 🖼 Rasm tanlash
              ImageUploadWidget(
                userId: userId!,
                storeId: storeVM.storeId.toString(),
                onImageUploaded: (url, fileId) {
                  uploadedImageUrl = url;
                  uploadedFileId = fileId;
                },
              ),

              /// Company
              CompanyDropdown(
                selectedCompanyId: selectedCompanyId,
                onChanged: (value) {
                  setState(() {
                    selectedCompanyId = value;
                  });
                },
              ),

              /// Model Name
              CustomTextfield(
                label: 'mobile_name'.tr,
                hint: 'enter_model'.tr,
                controller: modelController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'enter_model'.tr : null,
              ),

              /// Colour
              ColourDropdown(controller: colourController),

              // Yomkist (faqat iPhone)
              if (selectedCompanyId != null &&
                  Provider.of<CompanyViewModel>(context, listen: false)
                          .companies
                          .firstWhere((c) => c.id == selectedCompanyId!)
                          .name
                          .toLowerCase() ==
                      'iphone') ...[
                CustomTextfield(
                  label: 'Yomkist',
                  hint: 'Enter quantity',
                  controller: yomkistController,
                  keyboardType: TextInputType.number,
                ),
              ],

              /// Memory
              MemoryDropdownWidget(
                selectedMemory: selectedMemory,
                onChanged: (val) {
                  setState(() {
                    selectedMemory = val;
                  });
                },
              ),

              if (selectedCompanyId != null &&
                  Provider.of<CompanyViewModel>(context, listen: false)
                          .companies
                          .firstWhere((c) => c.id == selectedCompanyId!)
                          .name
                          .toLowerCase() !=
                      'iphone') ...[
                /// RAM
                CustomTextfield(
                  label: 'RAM',
                  hint: 'Enter RAM',
                  controller: ramController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter RAM'.tr : null,
                ),
              ],

              /// IMEI
              IMEIDropdown(
                selectedValue: imeiCount,
                onChanged: (val) {
                  setState(() {
                    imeiCount = val;
                  });
                },
              ),

              /// Status
              RadioRow<String>(
                label: "status".tr,
                selectedValue: statusValue,
                options: {"Yangi": "Yangi", "B/U": "B/U"},
                onChanged: (val) {
                  setState(() {
                    statusValue = val;
                  });
                },
              ),

              /// Box
              RadioRow<bool>(
                label: "box".tr,
                selectedValue: boxValue,
                options: {"box_yes".tr: true, "box_no".tr: false},
                onChanged: (val) {
                  setState(() {
                    boxValue = val;
                  });
                },
              ),

              /// Price
              CustomTextfield(
                label: 'price'.tr,
                hint: 'enter_price'.tr,
                controller: priceController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'enter_price'.tr : null,
              ),

              const SizedBox(height: 16),

              /// ✅ Buttonlar
              DialogButtons(
                onCancel: () => Navigator.of(context).pop(),
                onSubmit: submit,
                isLoading: isLoading,
                cancelText: "cancel".tr,
                submitText: "add".tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
