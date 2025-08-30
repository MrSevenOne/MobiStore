import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/options_show.dart';
import 'package:mobi_store/ui/core/ui/show/phonesale_show.dart';
import 'package:mobi_store/ui/provider/currency_viewmodel.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';
import 'package:mobi_store/utils/helper/currency_helper.dart';

class PhoneCard extends StatelessWidget {
  final PhoneModel phone;

  const PhoneCard({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 🔹 CurrencyViewModel ni olish
    final currencyVM = context.watch<CurrencyViewModel>();

    // 🔹 Narxlarni valyutaga konvert qilish (agar kurs tanlanmagan bo‘lsa, fallback UZSda ko‘rsatamiz)
    final buyPrice = CurrencyHelper.fromUzsFormatted(
        phone.buyPrice.toDouble(), currencyVM.selectedCurrency);

    final costPrice = CurrencyHelper.fromUzsFormatted(
        phone.CostPrice.toDouble(), currencyVM.selectedCurrency);

    Widget row(String titleKey, String? subtitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleKey.tr,
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
      onTap: () => debugPrint('Ontap: ${phone.id ?? "ID yo‘q"}'),
      onLongPress: () => OptionsShowWidget.show(context, phone),
      child: Container(
        padding: EdgeInsets.all(UiConstants.padding),
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
            // 🔹 Telefon nomi
            Text(
              "${phone.companyName.isNotEmpty ? phone.companyModel?.name : 'Noma’lum'} ${phone.modelName}",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            // 🔹 Rasm
            Center(
              child: phone.imageUrl == null || phone.imageUrl!.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/logo/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        height: 200,
                        width: double.maxFinite,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(UiConstants.borderRadius),
                          child: Image.network(
                            phone.imageUrl!,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
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
                CircleAvatar(
                  radius: 10.0,
                  backgroundColor: colorMap[phone.colour] ?? Colors.grey,
                ),
              ],
            ),

            // 🔹 Parametrlar
            row("Memory", "${phone.memory} GB"),
            if (phone.yomkist != null) row("Yomkist", "${phone.yomkist}"),
            if (phone.ram != 0) row("RAM", "${phone.ram} GB"),
            row("Status", phone.status),

            // 🔹 Box bor/yo‘qligi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Box",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                Icon(
                  phone.box ? Icons.check_circle : Icons.cancel,
                  color: phone.box ? Colors.green : Colors.red,
                  size: 20,
                ),
              ],
            ),

            // 🔹 Narxlar (konvert qilingan valyutada)
            row("Buy Price", buyPrice),
            row("Cost Price", costPrice),

            const SizedBox(height: 8.0),

            // 🔹 Sotish tugmasi
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return PhonesaleDialog(
                        onConfirm: (salePrice, paymentType) async {
                          final vm = context.read<PhoneReportViewModel>();
                          await vm.movePhoneToReport(
                            phoneId: phone.id!,
                            salePrice: salePrice,
                            paymentType: paymentType,
                          );
                          await context
                              .read<PhoneViewModel>()
                              .fetchPhonesByShop(phone.shopId);
                        },
                      );
                    },
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
