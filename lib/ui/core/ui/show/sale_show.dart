import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/dropdown/paymenttype_dropdown.dart';

class SaleDialog extends StatefulWidget {
  final void Function(double salePrice, int paymentType) onConfirm;

  const SaleDialog({super.key, required this.onConfirm});

  @override
  State<SaleDialog> createState() => _SaleDialogState();
}

class _SaleDialogState extends State<SaleDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  int _paymentType = 0; // default: cash

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
            SizedBox(height: 6.0),
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
                  return "sale_price_enter".tr;
                }
                if (double.tryParse(value) == null) {
                  return "invalid_number".tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            PaymentTypeDropdown(
              selectedValue: _paymentType,
              onChanged: (val) {
                setState(() {
                  _paymentType = val;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child:  Text("cancel".tr),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final price = double.parse(_priceController.text.trim());
              widget.onConfirm(price, _paymentType);
              Navigator.pop(context);
            }
          },
          child:  Text("config".tr),
        ),
      ],
    );
  }
}
