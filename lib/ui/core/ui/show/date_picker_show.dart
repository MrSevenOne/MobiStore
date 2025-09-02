import 'package:intl/intl.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/buttons/showdialog_button.dart';

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTime start, DateTime end) onApply;

  const DateRangePickerWidget({super.key, required this.onApply});

  static Future<DateTimeRange?> show(
    BuildContext context, {
    DateTimeRange? initialRange,
  }) async {
    DateTimeRange? result;

    await showDialog(
      context: context,
      builder: (ctx) {
        return DateRangePickerWidget(
          onApply: (start, end) {
            result = DateTimeRange(start: start, end: end);
          },
        );
      },
    );

    return result;
  }

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// From - To Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "from".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        startDate != null
                            ? DateFormat("EEE, dd MMM").format(startDate!)
                            : "--",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "to".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        endDate != null
                            ? DateFormat("EEE, dd MMM").format(endDate!)
                            : "--",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            /// Calendar (default flutter date picker range)
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
              onDateChanged: (date) {
                setState(() {
                  if (startDate == null ||
                      (startDate != null && endDate != null)) {
                    startDate = date;
                    endDate = null;
                  } else if (startDate != null && endDate == null) {
                    if (date.isBefore(startDate!)) {
                      endDate = startDate;
                      startDate = date;
                    } else {
                      endDate = date;
                    }
                  }
                });
              },
            ),

            const SizedBox(height: 12),

            /// Buttons
            DialogButtons(
              onCancel: () => Navigator.pop(context),
              onSubmit: () {
                if (startDate != null && endDate != null) {
                  widget.onApply(startDate!, endDate!);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


