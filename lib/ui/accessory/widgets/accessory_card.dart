import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/accessorysale_show.dart';
import 'package:mobi_store/ui/core/ui/show/options_accessory_show.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';

class AccessoryCard extends StatelessWidget {
  final AccessoryModel accessory;

  const AccessoryCard({super.key, required this.accessory});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 🔹 CurrencyViewModel dan foydalanamiz
    final currencyVM = context.watch<CurrencyViewModel>();

    // 🔹 Narxlarni valyutaga konvert qilish
    final buyPrice = currencyVM.formatFromUzs(accessory.buyPrice);
    final costPrice = currencyVM.formatFromUzs(accessory.costPrice);

    /// 🔹 Reusable row
    Widget row(String titleKey, String? subtitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleKey,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onPrimary,
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

    return Opacity(
      opacity: accessory.quantity == 0 ? 0.5 : 1.0, // Quantity 0 bo'lsa xiralashtirish
      child: InkWell(
        onTap: () => debugPrint('Ontap: ${accessory.id ?? "ID yo‘q"}'),
        onLongPress: () => OptionsAccessoryShowWidget.show(context, accessory),
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
          child: Stack(
            children: [
              // 🔹 Asosiy kontent (har doim ko'rinadi)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: accessory.imageUrl == null ||
                            accessory.imageUrl!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    UiConstants.borderRadius),
                              ),
                              child: Image.asset(
                                'assets/logo/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SizedBox(
                                  height: 200,
                                  width: constraints
                                      .maxWidth, // Konteyner kengligiga moslash
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        UiConstants.borderRadius),
                                    child: Image.network(
                                      accessory.imageUrl!,
                                      fit: BoxFit
                                          .contain, // Asl nisbati saqlanadi
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return ShimmerBox(
                                          height: 200,
                                          width: constraints.maxWidth,
                                          radius: 12.0,
                                        );
                                      },
                                      errorBuilder: (_, __, ___) => Image.asset(
                                        'assets/logo/logo.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),

                  const SizedBox(height: 12.0),

                  // 🔹 Brend
                  row("Brend", accessory.brand),

                  // 🔹 Rang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "colour".tr,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onPrimary,
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
                          backgroundColor:
                              colorMap[accessory.colour] ?? Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // 🔹 Miqdor
                  row("quantity".tr, "${accessory.quantity}"),

                  // 🔹 Narxlar (valyutaga konvert qilingan)
                  row("cost_price".tr, costPrice),
                  row("sale_price".tr, buyPrice),

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
                      onPressed: accessory.quantity == 0
                          ? null // Quantity 0 bo'lsa tugma faol emas
                          : () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AccessorySellDialog(
                                  accessoryModel: accessory,
                                ),
                              );
                            },
                      child: Text(
                        "sale".tr,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 🔹 "Mahsulot qolmadi" yozuvi (quantity 0 bo'lsa ustida chiqadi)
              if (accessory.quantity == 0)
                Center(
                  child: Container(
                    color: theme.colorScheme.error.withOpacity(0.8),
                    child: Center(
                      child: Text(
                        "Mahsulot qolmadi",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onError,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}