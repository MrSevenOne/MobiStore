import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';

enum ChartRangeType { week, month, year }

class StatChartCard extends StatelessWidget {
  final List<double>? data; // optional bo‘ldi
  final String title;
  final Color color;
  final ChartRangeType rangeType;
  final DateTime startDate;

  const StatChartCard({
    super.key,
    this.data,
    required this.title,
    required this.color,
    required this.rangeType,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// Agar data null bo‘lsa → default qiymat generatsiya qilamiz
    List<double> generateDefaultData() {
      switch (rangeType) {
        case ChartRangeType.week:
          return List.generate(7, (i) => (i * 3 + 5).toDouble());
        case ChartRangeType.month:
          final daysInMonth =
              DateTime(startDate.year, startDate.month + 1, 0).day;
          return List.generate(daysInMonth, (i) => (i % 7 + 4).toDouble());
        case ChartRangeType.year:
          return List.generate(12, (i) => (i + 1) * 10.0);
      }
    }

    final chartData = data ?? generateDefaultData();
    final totalValue = chartData.fold<int>(0, (a, b) => a + b.toInt());

    /// Pastki label (oy/kun/hafta)
    String getLabel(int index) {
      switch (rangeType) {
        case ChartRangeType.week:
          final day = startDate.add(Duration(days: index));
          return DateFormat("E").format(day); // Mon, Tue, ...
        case ChartRangeType.month:
          final day = DateTime(startDate.year, startDate.month, index + 1);
          return DateFormat("d").format(day); // 1,2,3...
        case ChartRangeType.year:
          return DateFormat("MMM").format(DateTime(startDate.year, index + 1));
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(UiConstants.borderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Yuqori qism
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: color, size: 12),
                const SizedBox(width: 6),
                Text(title, style: theme.textTheme.bodyMedium),
                const SizedBox(width: 20),
                Text(
                  "$totalValue",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            /// Diagramma
            SizedBox(
              height: 220,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width:
                      chartData.length * 40, // har bir bar/point uchun kenglik
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= chartData.length) {
                                return const SizedBox();
                              }
                              return Text(
                                getLabel(index),
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: List.generate(chartData.length, (i) {
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: chartData[i],
                              color: color,
                              width: 12,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
