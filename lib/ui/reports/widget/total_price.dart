import 'package:fl_chart/fl_chart.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:mobi_store/ui/provider/accessory_report_viewmodel.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/utils/formater/date_formater.dart';
import 'package:mobi_store/utils/helper/currency_helper.dart';

class TotalPriceCard extends StatelessWidget {
  const TotalPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer4<PhoneReportViewModel, AccessoryReportViewModel,
        DaterangeViewmodel, UserTariffViewModel>(
      builder: (context, phoneVm, accVm, dateVm, userTariffVm, _) {
        final range = dateVm.range;

        // Phone profitni hisoblash
        final phoneProfit =
            phoneVm.getTotalProfitByDateRange(range.start, range.end);

        return FutureBuilder<bool>(
          future: userTariffVm.hasAccessoryAccess(),
          builder: (context, snapshot) {
            // Shimmer-based loading widget
            Widget shimmerWidget = Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.colorScheme.secondary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(height: 20, width: 100, radius: 8),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerBox(height: 28, width: 120, radius: 8),
                          const SizedBox(height: 8.0),
                          ShimmerBox(height: 16, width: 150, radius: 8),
                        ],
                      ),
                      ShimmerBox(height: 70, width: 120, radius: 8),
                    ],
                  ),
                ],
              ),
            );

            // Main content widget
            Widget contentWidget() {
              double totalProfit = phoneProfit; // Faqat phone profit bilan boshlaymiz

              // Agar snapshot ready bo'lsa va accessory access true bo'lsa
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data == true) {
                final accessoryProfit =
                    accVm.getTotalProfitByDateRange(range.start, range.end);
                totalProfit += accessoryProfit; // Accessory profitni qo'shamiz
              }

              // Agar xatolik bo'lsa
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final currencyVM = context.watch<CurrencyViewModel>();
              final sum = CurrencyHelper.fromUzsFormatted(
                  totalProfit, currencyVM.selectedCurrency);

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: theme.colorScheme.secondary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "total_profit".tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sum,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${AppDateFormatter.formatDate(range.start)} - "
                              "${AppDateFormatter.formatDate(range.end)}",
                              style: theme.textTheme.bodySmall?.copyWith(
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
                              lineTouchData: LineTouchData(enabled: false),
                              lineBarsData: [
                                LineChartBarData(
                                  dotData: FlDotData(show: false),
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
                                  ),
                                  spots: [1, 1.5, 1.3, 2, 1.8, 3.5, 3.2]
                                      .asMap()
                                      .entries
                                      .map((e) => FlSpot(
                                            e.key.toDouble(),
                                            e.value.toDouble(),
                                          ))
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

            // DelayedLoader bilan loading holatini boshqarish
            return DelayedLoader(
              isLoading: snapshot.connectionState == ConnectionState.waiting,
              shimmer: shimmerWidget,
              child: contentWidget(),
              delay: const Duration(milliseconds: 500),
            );
          },
        );
      },
    );
  }
}