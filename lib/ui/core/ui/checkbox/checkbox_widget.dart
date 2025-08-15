import 'package:flutter/material.dart';

class RadioRow<T> extends StatelessWidget {
  final String label;
  final T selectedValue;
  final Map<String, T> options;
  final ValueChanged<T> onChanged;

  const RadioRow({
    Key? key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: theme.textTheme.bodyMedium,
        ),
        Row(
          children: options.entries.map((entry) {
            return Row(
              children: [
                Radio<T>(
                  value: entry.value,
                  groupValue: selectedValue,
                  onChanged: (val) {
                    if (val != null) onChanged(val);
                  },
                ),
                Text(entry.key,style: theme.textTheme.bodyMedium,),
                SizedBox(width: 24.0),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
