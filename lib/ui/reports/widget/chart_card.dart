import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';

class StatChartCard extends StatelessWidget {
  const StatChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer2<PhoneReportViewModel, DaterangeViewmodel>(
      builder: (context, phoneReportVM, dateRangeVM, child) {
        final start = dateRangeVM.range.start;
        final end = dateRangeVM.range.end;
        final chartData = phoneReportVM.getProfitDataByDateRange(start, end);

        if (chartData.isEmpty) {
          return Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(UiConstants.borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12.0,
              children: [
                Image.asset(
                  'assets/icons/emptyitem.png',
                  height: 96,
                ),
                Text(
                  "Ma'lumot mavjud emas",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          );
        }

        final parsed = chartData
            .map((e) => (
                  date: DateTime.tryParse(e.label) ?? DateTime.now(),
                  value: e.value,
                ))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

        final spots = List.generate(
          parsed.length,
          (i) => FlSpot(i.toDouble(), parsed[i].value),
        );

        String formatDate(DateTime d) => DateFormat('dd.MM.yyyy').format(d);

        return Container(
          padding: EdgeInsets.all(UiConstants.padding / 2),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(UiConstants.borderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Foyda diagrammasi",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: spots.length * 35, // har bir nuqtaga 40px joy
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (val, meta) {
                                  final i = val.toInt();
                                  if (i < 0 || i >= parsed.length) {
                                    return const SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      DateFormat('dd.MM')
                                          .format(parsed[i].date),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (touchedSpot) =>
                                  theme.colorScheme.primary,
                              tooltipRoundedRadius: 8.0, // radius
                              tooltipPadding:
                                  const EdgeInsets.all(8), // ichki padding
                              tooltipMargin: 12, // nuqtadan yuqoriga masofa
                              fitInsideHorizontally:
                                  true, // ekran tashqarisiga chiqib ketmasin
                              fitInsideVertically: true,
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((t) {
                                  final i = t.spotIndex;
                                  final d = parsed[i].date;
                                  return LineTooltipItem(
                                    "${formatDate(d)}\n${t.y.toStringAsFixed(2)} \$",
                                    TextStyle(
                                      color: theme.colorScheme
                                          .secondary, // matn oq, chunki fon qizil
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              barWidth: 3,
                              dotData: const FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    // ignore: deprecated_member_use
                                    Colors.blueAccent.withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueAccent,
                                  Colors.lightBlueAccent
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
