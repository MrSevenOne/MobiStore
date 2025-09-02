import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/export.dart';

class ColourDropdown extends StatefulWidget {
  final TextEditingController controller;

  const ColourDropdown({super.key, required this.controller});

  @override
  State<ColourDropdown> createState() => _ColourDropdownState();
}

class _ColourDropdownState extends State<ColourDropdown> {
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'colour'.tr,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.onSecondary),
          ),
        ),
        const SizedBox(height: 6.0),
        DropdownButtonFormField<String>(
          value: selectedColor,
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
              borderSide:
                  BorderSide(color: theme.colorScheme.primary, width: 1.5),
            ),
          ),
          hint: Text(
            "Select colour".tr,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.shadow,
              fontSize: 14,
            ),
          ),
          selectedItemBuilder: (context) {
            return colorMap.entries.map((entry) {
              return Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: colorMap[selectedColor] ?? Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.colorScheme.onSecondary),
                    ),
                  ),
                  Text(
                    selectedColor ?? '',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              );
            }).toList();
          },
          items: colorMap.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: entry.value,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.colorScheme.onSecondary),
                    ),
                  ),
                  Text(
                    entry.key.tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                selectedColor = val;
                widget.controller.text = val;
              });
            }
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'select_colour'.tr : null,
        ),
      ],
    );
  }
}
