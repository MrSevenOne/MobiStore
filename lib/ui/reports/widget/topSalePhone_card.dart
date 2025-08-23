import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';

class TopsalephoneCard extends StatelessWidget {
  const TopsalephoneCard({super.key});

  Color _getColorByIndex(int index) {
    const colors = [
      Colors.teal,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer2<PhoneReportViewModel, DaterangeViewmodel>(
      builder: (context, phoneVm, dateVm, child) {
        final top5 = phoneVm.getTop5ModelsByDateRange(
          dateVm.range.start,
          dateVm.range.end,
        );

        final chartData = top5.asMap().entries.map((entry) {
          final idx = entry.key;
          final e = entry.value;
          return _ChartModel(
            label: e.key,
            value: e.value,
            color: _getColorByIndex(idx),
          );
        }).toList();

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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _DonutChartWithLegend(data: chartData),
        );
      },
    );
  }
}

/// 📌 Chart model faqat shu faylda ishlatiladi
class _ChartModel {
  final String label;
  final int value;
  final Color color;

  _ChartModel({
    required this.label,
    required this.value,
    required this.color,
  });
}

/// 📌 DonutChart with Legend
class _DonutChartWithLegend extends StatelessWidget {
  final List<_ChartModel> data;

  const _DonutChartWithLegend({required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.fold<int>(0, (sum, e) => sum + e.value);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UiConstants.borderRadius),
        color: theme.colorScheme.secondary,
      ),
      child: Column(
        spacing: 12.0,
        children: [
          Text(
            "Ko'p sotilgan modellar",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.primary,
                ),
          ),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 50,
                sections: data.map((d) {
                  final percent = (d.value / total * 100).toStringAsFixed(1);
                  return PieChartSectionData(
                    value: d.value.toDouble(),
                    color: d.color,
                    title: "$percent%",
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: data.map((d) {
              final percent = (d.value / total * 100).toStringAsFixed(1);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 8.0,
                    backgroundColor: d.color,
                  ),
                  const SizedBox(width: 6),
                  Text("${d.label} (${d.value}) - $percent%"),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
