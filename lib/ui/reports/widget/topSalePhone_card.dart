import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobi_store/export.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';
import 'package:mobi_store/utils/chart_data.dart';

class TopSaleCard<T> extends StatelessWidget {
  final String title;
  final List<ChartData> Function(T vm, DateTime start, DateTime end) getData;

  const TopSaleCard({
    super.key,
    required this.title,
    required this.getData,
  });

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

    return Consumer2<T, DaterangeViewmodel>(
      builder: (context, reportVM, dateVM, child) {
        final data = getData(reportVM, dateVM.range.start, dateVM.range.end);

        if (data.isEmpty) {
          return Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(UiConstants.borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/emptyitem.png', height: 96),
                const SizedBox(height: 12),
                Text("no_data_available".tr,
                    style: theme.textTheme.bodySmall),
              ],
            ),
          );
        }

        final total = data.fold<double>(0, (sum, e) => sum + e.value);

        final chartData = data.asMap().entries.map((entry) {
          final idx = entry.key;
          final e = entry.value;
          return _ChartModel(
            label: e.label,
            value: e.value,
            color: _getColorByIndex(idx),
          );
        }).toList();

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiConstants.borderRadius),
            color: theme.colorScheme.secondary,
          ),
          child: Column(
            spacing: 12.0,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 50,
                    sections: chartData.map((d) {
                      final percent = (d.value / total * 100).toStringAsFixed(1);
                      return PieChartSectionData(
                        value: d.value,
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
              Padding(
                padding: const EdgeInsets.only(left: 24.0,top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: chartData.map((d) {
                    final percent = (d.value / total * 100).toStringAsFixed(1);
                    return Row(
                      children: [
                        CircleAvatar(radius: 8.0, backgroundColor: d.color),
                        const SizedBox(width: 6),
                        Text("${d.label} (${d.value.toInt()}) - $percent%"),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 📌 Faqat shu faylda ishlatiladi
class _ChartModel {
  final String label;
  final double value;
  final Color color;

  _ChartModel({
    required this.label,
    required this.value,
    required this.color,
  });
}
