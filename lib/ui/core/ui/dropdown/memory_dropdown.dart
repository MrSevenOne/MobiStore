// memory_dropdown_widget.dart
import 'package:mobi_store/export.dart';

class MemoryDropdownWidget extends StatelessWidget {
  final int? selectedMemory;
  final ValueChanged<int?> onChanged;

  const MemoryDropdownWidget({
    super.key,
    required this.selectedMemory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<int> memories = [
      16,
      32,
      64,
      128,
      256,
      512,
      1024
    ]; // Example options
    final theme = Theme.of(context);

    return Column(
      children: [
         Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'memory'.tr,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.onSecondary),
          ),
        ),
        const SizedBox(height: 6.0),
        DropdownButtonFormField<int>(
          value: selectedMemory,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.onSecondary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: theme.colorScheme.onSecondary, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            ),
          ),
          hint: Text(
            "select_memory".tr,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.shadow,
              fontSize: 14,
            ),
          ),
          items: memories
              .map((mem) => DropdownMenuItem(
                    value: mem,
                    child: Text('$mem GB',style: theme.textTheme.bodyMedium,),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Please select memory'.tr : null,
        ),
      ],
    );
  }
}
