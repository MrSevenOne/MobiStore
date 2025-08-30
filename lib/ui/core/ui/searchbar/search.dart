import 'package:flutter/material.dart';

class UniversalSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final IconData prefixIcon;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const UniversalSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = "Qidirish...",
    this.prefixIcon = Icons.search,
    this.padding = const EdgeInsets.only(right: 12, left: 12, top: 24),
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          filled: true,
          fillColor: theme.colorScheme.secondary,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
