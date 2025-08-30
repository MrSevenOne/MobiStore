import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/dropdown/paymenttype_dropdown.dart';
import 'package:mobi_store/ui/core/ui/textfield/currency_textcontroller.dart';
import 'package:mobi_store/ui/provider/accessory_report_viewmodel.dart';
import 'package:mobi_store/ui/provider/accessory_viewmodel.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';
import 'package:provider/provider.dart';

class AccessorySellDialog extends StatefulWidget {
  final AccessoryModel accessoryModel;

  const AccessorySellDialog({
    super.key,
    required this.accessoryModel,
  });

  @override
  State<AccessorySellDialog> createState() => _AccessorySellDialogState();
}

class _AccessorySellDialogState extends State<AccessorySellDialog> {
  final _formKey = GlobalKey<FormState>();
  int selectedPaymentType = 0; // 0 = Cash, 1 = Card, 2 = Transfer
  bool _isLoading = false;

  late CurrencyTextController salePriceController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    salePriceController = CurrencyTextController(); // ✅ endi context kerak emas
    quantityController = TextEditingController(text: "1"); // default 1
  }

  @override
  void dispose() {
    salePriceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final saleQuantity = int.tryParse(quantityController.text) ?? 1;
    setState(() => _isLoading = true);

    final paymentTypeMap = {0: 'Cash', 1: 'Card', 2: 'Transfer'};

    final reportVM = context.read<AccessoryReportViewModel>();
    final accessoryVM = context.read<AccessoryViewModel>();
    final currencyVM = context.read<CurrencyViewModel>();

    // 🔹 Controller → raw double
    final rawPrice = salePriceController.numericValue;

    // 🔹 Always convert to UZS
    final salePriceUzs = currencyVM.toUzsNumeric(rawPrice).toInt();

    final success = await reportVM.addAccessoryToReport(
      accessoryId: widget.accessoryModel.id ?? '',
      saleQuantity: saleQuantity,
      salePrice: salePriceUzs, // ✅ endi doim UZS va int
      paymentType: paymentTypeMap[selectedPaymentType]!,
      storeId: widget.accessoryModel.storeId,
    );

    if (success) {
      await accessoryVM.fetchAccessories(
        widget.accessoryModel.storeId,
        widget.accessoryModel.categoryId ?? '',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Accessory sold successfully")),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to sell accessory")),
        );
      }
    }

    if (mounted) Navigator.of(context).pop();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        "Sell Accessory",
        style: theme.textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sale price
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'sale_price'.tr,
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onSecondary),
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: salePriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'sale_price'.tr,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: theme.colorScheme.onSecondary, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'sale_price_enter'.tr;
                }
                if (double.tryParse(value.replaceAll(',', '').replaceAll(' ', '')) == null) {
                  return 'invalid_number'.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            // Quantity
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'quantity'.tr,
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onSecondary),
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'quantity'.tr,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: theme.colorScheme.onSecondary, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                final qty = int.tryParse(value ?? '');
                if (qty == null) return 'invalid_number'.tr;
                if (qty <= 0) return 'quantity_must_be_positive'.tr;
                if (qty > widget.accessoryModel.quantity) {
                  return "Only ${widget.accessoryModel.quantity} available";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Payment type
            PaymentTypeDropdown(
              selectedValue: selectedPaymentType,
              onChanged: (val) => setState(() => selectedPaymentType = val),
            ),
          ],
        ),
      ),
      actions: [
        DialogButtons(
          isLoading: _isLoading,
          cancelText: "cancel".tr,
          submitText: "config".tr,
          onCancel: () => Navigator.of(context).pop(),
          onSubmit: _handleSubmit,
        ),
      ],
    );
  }
}
