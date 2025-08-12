import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:provider/provider.dart';
import '../view_model/store_view_model.dart';

class StoreAddDialog extends StatefulWidget {
  const StoreAddDialog({super.key});

  @override
  State<StoreAddDialog> createState() => _StoreAddDialogState();

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const StoreAddDialog(),
    );
  }
}

class _StoreAddDialogState extends State<StoreAddDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final viewModel = context.read<StoreViewModel>();
      await viewModel.createStore(_nameController.text.trim(),  _locationController.text.trim());

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
          "store_create".tr,
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
                style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black)),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "store_name_add".tr),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? "Majburiy maydon" : null,
            ),
            const SizedBox(height: 12),
            Text("store_location".tr,
                style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black)),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(hintText: 'store_location_add'.tr),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? "Majburiy maydon" : null,
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
