import 'package:flutter/material.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';
import 'package:mobi_store/utils/helper/currency_helper.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';

class TotalCard<T> extends StatelessWidget {
  final String title;
  final double Function(T vm, DateTime start, DateTime end) getTotal;

  const TotalCard({
    super.key,
    required this.title,
    required this.getTotal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer2<T, DaterangeViewmodel>(
      builder: (context, reportVm, dateVm, _) {
        final range = dateVm.range;
        final total = getTotal(reportVm, range.start, range.end);
        final currencyVM = context.watch<CurrencyViewModel>();
//formated sum
        final sum =
            CurrencyHelper.fromUzsFormatted(total, currencyVM.selectedCurrency);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: theme.colorScheme.secondary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Title
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              /// 🔹 Value + Date Range
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sum,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
