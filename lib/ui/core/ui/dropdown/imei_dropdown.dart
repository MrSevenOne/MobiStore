import 'package:mobi_store/export.dart';

class IMEIDropdown extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int> onChanged;

  const IMEIDropdown({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Map<String, int> options = {
      'O‘tmagan': 0,
      '1 ta': 1,
      '2 ta': 2,
    };

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'imei'.tr,
            style: theme.textTheme.bodyMedium!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
        SizedBox(height: 6.0),
        DropdownButtonFormField<int>(
          value: selectedValue,
          items: options.entries
              .map(
                (e) => DropdownMenuItem<int>(
                  value: e.value,
                  child: Text(
                    e.key,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
          validator: (value) => value == null ? 'select_imei'.tr : null,
        ),
      ],
    );
  }
}
