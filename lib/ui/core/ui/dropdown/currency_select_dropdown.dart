import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/domain/models/currency_model.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyVM = Provider.of<CurrencyViewModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Currency", style: theme.textTheme.bodyMedium),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: DropdownButton<CurrencyModel>(
            value: currencyVM.selectedCurrency,
            underline: const SizedBox(),
            dropdownColor: theme.colorScheme.surface,
            style: theme.textTheme.bodyMedium,
            items: currencyVM.currencies.map((currency) {
              return DropdownMenuItem<CurrencyModel>(
                value: currency,
                child: Text(currency.ccy),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                currencyVM.setCurrency(value);
              }
            },
          ),
        ),
      ],
    );
  }
}
