import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:provider/provider.dart';
import '../view_model/shop_viewmodel.dart';
import '../../../domain/models/shop_model.dart'; // agar store modeli shu yerda bo‘lsa

class ShopEditDialog extends StatefulWidget {
  final ShopModel shopModel; // Tahrir qilinadigan do‘kon

  const ShopEditDialog({super.key, required this.shopModel});

  @override
  State<ShopEditDialog> createState() => _ShopEditDialogState();

  static Future<void> show(BuildContext context, ShopModel shopModel) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ShopEditDialog(shopModel: shopModel),
    );
  }
}

class _ShopEditDialogState extends State<ShopEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.shopModel.storeName);
    _locationController = TextEditingController(text: widget.shopModel.address);
  }

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isSubmitting = true);

  try {
    final editShop = widget.shopModel.copyWith(
      name: _nameController.text.trim(),
      address: _locationController.text.trim(),
    );

    final viewModel = context.read<ShopViewmodel>();
    await viewModel.updateStore(editShop);

    if (mounted) Navigator.pop(context); // ✅ muvaffaqiyatli bo‘lsa dialog yopiladi
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Xatolik: $e")),
    );
  } finally {
    if (mounted) setState(() => _isSubmitting = false);
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Align(
        alignment: Alignment.topCenter,
        child: Text(
          "store_edit".tr,
          style: theme.textTheme.titleSmall,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("store_name".tr,
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.black)),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "store_name_add".tr),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? "Majburiy maydon"
                  : null,
            ),
            const SizedBox(height: 12),
            Text("store_location".tr,
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.black)),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(hintText: 'store_location_add'.tr),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? "Majburiy maydon"
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        DialogButtons(
          onCancel: () => Navigator.pop(context),
          onSubmit: _submit,
          isLoading: _isSubmitting, // 🔹 Button ichida loading ko‘rinadi
        ),
      ],
    );
  }
}
