import 'package:flutter/material.dart';
import 'package:mobi_store/ui/core/ui/dropdown/accessories_category_dropdown.dart';
import 'package:mobi_store/ui/core/ui/dropdown/colour_dropdown.dart';
import 'package:mobi_store/ui/core/ui/imageupload_widget.dart';
import 'package:mobi_store/utils/user/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/textfield/custom_textfield.dart';
import 'package:mobi_store/ui/core/ui/snack_bar/snackbar_widget.dart';
import 'package:mobi_store/ui/provider/accessory_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class AccessoryAddPage extends StatefulWidget {
  const AccessoryAddPage({super.key});

  @override
  State<AccessoryAddPage> createState() => _AccessoryAddPageState();
}

class _AccessoryAddPageState extends State<AccessoryAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController colourController = TextEditingController();
  final TextEditingController quantityController =
      TextEditingController(text: "1");

  String? selectedCategoryId;
  String? uploadedImageUrl;
  String? uploadedFileId;
  bool isLoading = false;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final storeVM = Provider.of<SelectedStoreViewModel>(context, listen: false);
    final storeId = int.tryParse(storeVM.storeId.toString()) ?? 0;
    final userId = UserManager.currentUserId ?? "";

    final accessory = AccessoryModel(
      name: nameController.text.trim(),
      price: int.tryParse(priceController.text.trim()) ?? 0,
      categoryId: selectedCategoryId,
      brand: brandController.text.trim(),
      colour: colourController.text.trim(),
      imageUrl: uploadedImageUrl,
      storeId: storeId,
      userId: userId,
      createdAt: DateTime.now(),
      quantity: int.tryParse(quantityController.text.trim()) ?? 1,
    );

    final accessoryVM = Provider.of<AccessoryViewModel>(context, listen: false);
    final result = await accessoryVM.addAccessory(accessory);

    if (result != null) {
      SnackBarWidget.showSuccess(
          "Accessory qo‘shildi", 'Accessory muvaffaqiyatli qo‘shildi');
    } else {
      SnackBarWidget.showError(
          "Xatolik", 'Accessory qo‘shishda xatolik yuz berdi');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final storeVM = Provider.of<SelectedStoreViewModel>(context);
    final userId = UserManager.currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Accessory"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
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
                folderType: 'accessories',
              ),

              /// Category
              CategoryDropdown(
                selectedCategoryId: selectedCategoryId,
                onChanged: (value) {
                  setState(() {
                    selectedCategoryId = value;
                  });
                },
              ),

              /// Name
              CustomTextfield(
                label: 'Name',
                hint: 'Enter accessory name',
                controller: nameController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter name' : null,
              ),

              /// Price
              CustomTextfield(
                label: 'Price',
                hint: 'Enter price',
                controller: priceController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter price' : null,
              ),

              /// Brand
              CustomTextfield(
                label: 'Brand',
                hint: 'Enter brand',
                controller: brandController,
              ),

              /// Colour
              ColourDropdown(controller: colourController),

              /// Quantity
              CustomTextfield(
                label: 'Quantity',
                hint: 'Enter quantity',
                controller: quantityController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter quantity' : null,
              ),

              const SizedBox(height: 16),

              /// ✅ Buttonlar
              DialogButtons(
                onCancel: () => Navigator.of(context).pop(),
                onSubmit: submit,
                isLoading: isLoading,
                cancelText: "Cancel",
                submitText: "Add",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
