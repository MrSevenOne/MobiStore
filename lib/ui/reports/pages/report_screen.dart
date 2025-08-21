import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/date_picker_show.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';
import 'package:mobi_store/ui/reports/diagram/stat_chart_card.dart';
import 'package:mobi_store/ui/reports/pages/widget/total_price.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  Future<void> _pickDateRange(BuildContext context) async {
    final provider = context.read<DaterangeViewmodel>();
    final picked = await DateRangePickerWidget.show(
      context,
      initialRange: provider.range,
    );
    if (picked != null) {
      provider.setRange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Reports"),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () => _pickDateRange(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            TotalPriceCard(), // ✅ endi umumiy range ishlatadi
            StatChartCard(
              data: [10, 5, 8, 12, 7, 6, 9,90,70],
              title: "Haftalik sotuvlar",
              color: Colors.green,
              rangeType: ChartRangeType.year,
              startDate: DateTime(2025, 10, 18),
            ),
          ],
        ),
      ),
    );
  }
}
