import 'package:mobi_store/export.dart';
import 'package:flutter/services.dart';
import 'package:mobi_store/utils/formater/price_formater.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextfield({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Agar number bo‘lsa va foydalanuvchi tashqi formatter bermagan bo‘lsa
    final effectiveFormatters = <TextInputFormatter>[
      if (keyboardType == TextInputType.number &&
          (inputFormatters == null || inputFormatters!.isEmpty))
        PriceFormatter.inputFormatter(),
      ...?inputFormatters,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label.tr,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: effectiveFormatters, // 👈 qo‘shildi
          validator: validator,
        ),
      ],
    );
  }
}
