import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/colour_map.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';

class PhoneReportCard extends StatelessWidget {
  final PhoneReportModel report;

  const PhoneReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget row(String title, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall,
          ),
        ],
      );
    }

    return Container(
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
          // 📷 Image
          Center(
            child: report.imageUrl == null || report.imageUrl!.isEmpty
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
                      report.imageUrl!,
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
                  ),
          ),

          const SizedBox(height: 4),

          // 📱 Model
          Text(
            "${report.companyModel?.name} ${report.modelName}",
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          // 🎨 Rang
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
                radius: 8,
                backgroundColor: colorMap[report.colour] ?? Colors.grey,
              ),
            ],
          ),

          row("Memory", "${report.memory} GB"),
          if (report.yomkist != null) row("Yomkist", "${report.yomkist}"),
          if (report.ram != null && report.ram != 0)
            row("RAM", "${report.ram} GB"),
          row("Status", report.status),

          // 📦 Box bor/yo‘qligi
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
                report.box ? Icons.check_circle : Icons.cancel,
                color: report.box ? Colors.green : Colors.red,
                size: 20,
              ),
            ],
          ),

          // 💵 Sotilish narxi
          row("Retail price", "${report.price} \$"),
          row("Sale price", "${report.salePrice} \$"),

          // 🕒 Sotilgan vaqt
          // row("Sale time",
          //     report.saleTime.toLocal().toString().substring(0, 16)),

          // 💳 To‘lov turi
          row("Payment type", _getPaymentName(report.paymentType)),
        ],
      ),
    );
  }

  /// To‘lov turini ko‘rsatish
  String _getPaymentName(int type) {
    switch (type) {
      case 0:
        return "Naqd";
      case 1:
        return "Karta";
      case 2:
        return "Bank";
      default:
        return "Noma’lum";
    }
  }
}
