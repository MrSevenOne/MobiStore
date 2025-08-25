import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/accessorysale_show.dart';

class AccessoryCard extends StatelessWidget {
  final AccessoryModel accessory;

  const AccessoryCard({super.key, required this.accessory});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget row(String titleKey, String? subtitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleKey,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          Text(
            subtitle ?? 'N/A',
            style: theme.textTheme.bodySmall,
          ),
        ],
      );
    }

    return InkWell(
      onTap: () => debugPrint('Ontap: ${accessory.id}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6.0,
          children: [
            Center(
              child: accessory.imageUrl == null || accessory.imageUrl!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Image.asset(
                        'assets/logo/logo.png',
                        height: 80.0,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Image.network(accessory.imageUrl!,
                          height: 100,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return ShimmerBox(
                              height: 100,
                              width: double.infinity,
                              radius: 0.0,
                            );
                          },
                          errorBuilder: (_, __, ___) => Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Image.asset(
                                  'assets/logo/logo.png',
                                  height: 100.0,
                                  fit: BoxFit.fill,
                                ),
                              )),
                    ),
            ),
            const SizedBox(height: 6.0),
            Text(
              accessory.name,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            row("Brend", accessory.brand),
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
                  padding: const EdgeInsets.all(2), // border qalinligi
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme
                        .colorScheme.shadow, // border rangi (shadow sifatida)
                  ),
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor:
                        colorMap[accessory.colour] ?? Colors.grey, // fon rangi
                  ),
                ),
              ],
            ),
            row("Quantity", "${accessory.quantity}"),
            row("Price", "${accessory.price} \$"),
            const SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
                child: Text("Sale".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
