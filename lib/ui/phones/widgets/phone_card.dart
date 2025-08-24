import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/options_show.dart';
import 'package:mobi_store/ui/core/ui/show/sale_show.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';

class PhoneCard extends StatelessWidget {
  final PhoneModel phone;

  const PhoneCard({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget row(String titleKey, String? subtitle) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleKey.tr,
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
      onTap: () => debugPrint('Ontap: ${phone.id ?? "ID yo‘q"}'),
      onLongPress: () => OptionsShowWidget.show(context, phone),
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
                child: phone.imageUrl == null || phone.imageUrl!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Image.asset(
                          'assets/logo/logo.png',
                          height: 100.0,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Image.network(
                          phone.imageUrl!,
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
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.phone_android,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                      )),
            const SizedBox(height: 2.0),
            Text(
              "${phone.companyName.isNotEmpty ? phone.companyModel?.name : 'Noma’lum'} ${phone.modelName}",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "colour".tr,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2), // border qalinligi
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.shadow, // border rangi (shadow sifatida)
                  ),
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: colorMap[phone.colour] ?? Colors.grey, // fon rangi
                  ),
                ),
              ],
            ),
            row("memory", "${phone.memory} GB"),
            if (phone.yomkist != null) row("yomkist", "${phone.yomkist}"),
            if (phone.ram != 0) row("RAM", "${phone.ram} GB"),
            row("status", phone.status),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "box".tr,
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
            row("Buy Price", '${phone.buyPrice} \$'),
            row("Cost Price", '${phone.CostPrice} \$'),
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
                    builder: (ctx) {
                      return SaleDialog(
                        onConfirm: (salePrice, paymentType) async {
                          final vm = context.read<PhoneReportViewModel>();
                          print("phone ID: ${phone.id}");
                          await vm.movePhoneToReport(
                            phoneId: phone.id!,
                            salePrice: salePrice,
                            paymentType: paymentType,
                          );
                          context
                              .read<PhoneViewModel>()
                              .fetchPhonesByShop('${phone.id}');
                        },
                      );
                    },
                  );
                },
                child: Text("sale".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
