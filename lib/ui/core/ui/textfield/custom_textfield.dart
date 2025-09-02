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
                .copyWith(color: theme.colorScheme.onSecondary),
          ),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
          keyboardType: keyboardType,
          inputFormatters: effectiveFormatters, // 👈 qo‘shildi
          decoration: InputDecoration(
            hintText: hint.tr,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: theme.colorScheme.onSecondary, width: 1),
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
          validator: validator,
        ),
      ],
    );
  }
}
