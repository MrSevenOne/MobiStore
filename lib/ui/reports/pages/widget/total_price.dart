import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobi_store/ui/core/ui/show/date_picker_show.dart';
import 'package:mobi_store/utils/formater/date_formater.dart';

class TotalPriceCard extends StatefulWidget {
  const TotalPriceCard({super.key});

  @override
  State<TotalPriceCard> createState() => _ProfitSummaryCardState();
}

class _ProfitSummaryCardState extends State<TotalPriceCard> {
  DateTimeRange? _selectedRange;
  double totalProfit = 1500000; // dummy summa (so'm)

  // Default: oy boshidan hozirgacha
  DateTimeRange get defaultRange {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    return DateTimeRange(start: startOfMonth, end: now);
  }

  Future<void> _openDateRangePicker() async {
    final pickedRange = await DateRangePickerWidget.show(
      context,
      initialRange: _selectedRange ?? defaultRange,
    );

    if (pickedRange != null) {
      setState(() {
        _selectedRange = pickedRange;
        totalProfit = 2500000; // dummy qiymat
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final range = _selectedRange ?? defaultRange;
    final theme = Theme.of(context);

    // bitta qilib yozilgan UI
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: theme.colorScheme.secondary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Profit",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${1240} \$",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "${AppDateFormatter.formatDate(range.start)} - "
                    "${AppDateFormatter.formatDate(range.end)}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.shadow,
                        ),
                  ),
                ],
              ),
              SizedBox(
                width: 120,
                height: 70,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineTouchData: LineTouchData(
                      enabled: false,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        dotData: FlDotData(show: false), // nuqtalar yashirilgan
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ), // ostidagi gradient/fon yo‘q
                        spots: [1, 1.5, 1.3, 2, 1.8, 3.5, 3.2]
                            .asMap()
                            .entries
                            .map((e) =>
                                FlSpot(e.key.toDouble(), e.value.toDouble()))
                            .toList(),
                        isCurved: true,
                        color: Colors.green,
                        barWidth: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
