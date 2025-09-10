import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';
import 'package:mobi_store/ui/core/ui/dropdown/paymenttype_dropdown.dart';
import 'package:mobi_store/ui/core/ui/textfield/currency_textcontroller.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';

class PhonesaleDialog extends StatefulWidget {
  final Future<void> Function(double salePrice, int paymentType) onConfirm;

  const PhonesaleDialog({super.key, required this.onConfirm});

  @override
  State<PhonesaleDialog> createState() => _PhonesaleDialogState();
}

class _PhonesaleDialogState extends State<PhonesaleDialog> {
  final _formKey = GlobalKey<FormState>();
  int _paymentType = 0; // default: cash
  bool _isLoading = false;

  late CurrencyTextController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = CurrencyTextController(); // ✅ endi context kerak emas
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final currencyVM = Provider.of<CurrencyViewModel>(context, listen: false);

    // ✅ Controller → numericValue
    final rawPrice = _priceController.numericValue;

    // ✅ ViewModel → UZS ga o‘tkazish
    final price = currencyVM.toUzsNumeric(rawPrice);

    await widget.onConfirm(price, _paymentType);

    if (mounted) Navigator.pop(context);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        "sale_phone".tr,
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              controller: _priceController,
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
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "sale_price_enter".tr;
                }
                if (double.tryParse(value.replaceAll(',', '').replaceAll(' ', '')) == null) {
                  return "invalid_number".tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            PaymentTypeDropdown(
              selectedValue: _paymentType,
              onChanged: (val) => setState(() => _paymentType = val),
            ),
          ],
        ),
      ),
      actions: [
        DialogButtons(
          isLoading: _isLoading,
          cancelText: "cancel".tr,
          submitText: "ok".tr,
          onCancel: () => Navigator.pop(context),
          onSubmit: _handleSubmit, // async handler
        ),
      ],
    );
  }
}
