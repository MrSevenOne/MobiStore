import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/checkbox/checkbox_widget.dart';
import 'package:mobi_store/ui/core/ui/dropdown/colour_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/company_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/imei_dropdown.dart';
import 'package:mobi_store/ui/core/ui/textfield/custom_textfield.dart';
import 'package:mobi_store/ui/home/widgets/imageupload_widget.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class PhoneAddWidget extends StatefulWidget {
  const PhoneAddWidget({super.key});

  @override
  State<PhoneAddWidget> createState() => _PhoneAddWidgetState();

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PhoneAddWidget(),
    );
  }
}

class _PhoneAddWidgetState extends State<PhoneAddWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colourController = TextEditingController();
  final TextEditingController yomkistController = TextEditingController();
  final TextEditingController imeiController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? selectedCompanyId;
  int imeiCount = 0;
  String statusValue = "Yangi";
  bool boxValue = true;

  bool isLoading = false;
  String? uploadedImageUrl;

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
      imageUrl: uploadedImageUrl!,
    );

    final phoneVM = Provider.of<PhoneViewModel>(context, listen: false);
    final result = await phoneVM.addPhone(phone);

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("phone_added_success".tr)),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("phone_added_error".tr)),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.8;
    final storeVM = Provider.of<SelectedStoreViewModel>(context);
    //User ID
    final userId = UserManager.currentUserId;

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
                    "add_phone".tr,
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.colorScheme.onSecondary),
                  ),

                  /// 🖼 Rasm tanlash va yuklash
                  ImageUploadWidget(
                    userId: userId!,
                    storeId: storeVM.storeId.toString(),
                    onImageUploaded: (url) {
                      uploadedImageUrl = url;
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
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_model'.tr
                        : null,
                  ),

                  /// Colour
                  ColourDropdown(controller: colourController),

                  /// Agar company iPhone bo‘lsa yomkist chiqadi
                  if (selectedCompanyId != null &&
                      selectedCompanyId!.toLowerCase() == "Iphone")
                    CustomTextfield(
                      label: 'yomkist'.tr,
                      hint: 'enter_yomkist'.tr,
                      controller: yomkistController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter_yomkist'.tr;
                        }
                        if (int.tryParse(value) == null) {
                          return 'enter_valid_number'.tr;
                        }
                        return null;
                      },
                    ),

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
                    validator: (value) => value == null || value.isEmpty
                        ? 'enter_price'.tr
                        : null,
                  ),

                  const SizedBox(height: 16),

                  /// ✅ Yangicha buttonlar
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
        ),
      ),
    );
  }
}
