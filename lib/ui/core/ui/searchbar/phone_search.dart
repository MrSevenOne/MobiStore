import 'package:mobi_store/export.dart';

class PhoneSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const PhoneSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        right: 12.0,
        left: 12.0,
        top: 24.0,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "search_phone".tr,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          filled: true,
          fillColor: theme.colorScheme.secondary,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
