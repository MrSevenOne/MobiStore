import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/accessorysale_show.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';
import 'package:mobi_store/utils/helper/currency_helper.dart';

class AccessoryCard extends StatelessWidget {
  final AccessoryModel accessory;

  const AccessoryCard({super.key, required this.accessory});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 🔹 CurrencyViewModel dan foydalanamiz
    final currencyVM = context.watch<CurrencyViewModel>();

  // 🔹 Narxlarni valyutaga konvert qilish (agar kurs tanlanmagan bo‘lsa, fallback UZSda ko‘rsatamiz)
    final buyPrice = CurrencyHelper.fromUzsFormatted(
        accessory.buyPrice, currencyVM.selectedCurrency);

    final costPrice = CurrencyHelper.fromUzsFormatted(
        accessory.costPrice, currencyVM.selectedCurrency);

    /// 🔹 Reusable row
    Widget row(String titleKey, String? subtitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleKey,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              subtitle ?? 'N/A',
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.shadow),
              textAlign: TextAlign.right,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () => debugPrint('Ontap: ${accessory.id ?? "ID yo‘q"}'),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(UiConstants.borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6.0,
          children: [
            // 🔹 Nomi
            Text(
              accessory.name,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            // 🔹 Rasm
            Center(
              child: accessory.imageUrl == null || accessory.imageUrl!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(UiConstants.borderRadius),
                        ),
                        child: Image.asset(
                          'assets/logo/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(UiConstants.borderRadius),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(UiConstants.borderRadius),
                          child: Image.network(
                            accessory.imageUrl!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return ShimmerBox(
                                height: 220,
                                width: double.infinity,
                                radius: 12.0,
                              );
                            },
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/logo/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 6.0),

            // 🔹 Brend
            row("Brend", accessory.brand),

            // 🔹 Rang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Colour",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.shadow,
                  ),
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: colorMap[accessory.colour] ?? Colors.grey,
                  ),
                ),
              ],
            ),

            // 🔹 Miqdor
            row("Quantity", "${accessory.quantity}"),

            // 🔹 Narxlar (valyutaga konvert qilingan)
            row("Cost Price", costPrice),
            row("Buy Price", buyPrice),

            const SizedBox(height: 8.0),

            // 🔹 Sotish tugmasi
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(UiConstants.borderRadius),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AccessorySellDialog(
                      accessoryModel: accessory,
                    ),
                  );
                },
                child: Text(
                  "Sale".tr,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
