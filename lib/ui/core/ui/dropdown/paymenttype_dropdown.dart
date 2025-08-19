import 'package:mobi_store/export.dart';

class PaymentTypeDropdown extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int> onChanged;

  const PaymentTypeDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Map<String, int> options = {
      'Cash': 0,
      'Card': 1,
      'Transfer': 2,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'payment_type'.tr,
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colorScheme.onSecondary),
        ),
        const SizedBox(height: 6.0),
        DropdownButtonFormField<int>(
          value: selectedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          items: options.entries
              .map(
                (e) => DropdownMenuItem<int>(
                  value: e.value,
                  child: Text(
                    e.key,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
          validator: (value) => value == null ? 'select_payment_type'.tr : null,
        ),
      ],
    );
  }
}
