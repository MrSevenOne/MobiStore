import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:mobi_store/utils/formater/date_formater.dart';

class UserTariffWidget extends StatefulWidget {
  const UserTariffWidget({super.key});

  @override
  State<UserTariffWidget> createState() => _UserTariffWidgetState();
}

class _UserTariffWidgetState extends State<UserTariffWidget> {
  @override
  void initState() {
    super.initState();
    // 🔹 initState da fetch qilish
    Future.microtask(() {
      final vm = context.read<UserTariffViewModel>();
      vm.fetchUserTariff(UserManager.currentUserId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Helper function for date rows
    Widget date(String title, String subtitle) {
      return Row(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$title:", style: theme.textTheme.bodySmall),
          Text(subtitle, style: theme.textTheme.bodySmall),
        ],
      );
    }

    return Consumer<UserTariffViewModel>(
      builder: (context, vm, _) {
        // Shimmer placeholder for loading state
        Widget shimmerWidget = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiConstants.borderRadius),
            color: theme.colorScheme.secondary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              ShimmerBox(height: 24, width: 24, radius: 12), // Leading icon
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(height: 20, width: 120, radius: 8), // Title
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerBox(height: 16, width: 80, radius: 8), // Start date
                        ShimmerBox(height: 16, width: 80, radius: 8), // End date
                      ],
                    ),
                  ],
                ),
              ),
              ShimmerBox(height: 16, width: 16, radius: 8), // Trailing icon
            ],
          ),
        );

        // Main content widget
        Widget contentWidget() {
          if (vm.errorMessage != null) {
            return ListTile(
              leading: const Icon(Icons.error, color: Colors.red),
              title: const Text("Tariff info error"),
              subtitle: Text(vm.errorMessage!),
            );
          }

          if (vm.userTariff == null) {
            return ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text("No tariff selected"),
              subtitle: const Text("Please select a tariff"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // 👉 tarif tanlash sahifasiga yo‘naltirish
              },
            );
          }

          final tariff = vm.userTariff!;
          final startDate = AppDateFormatter.formatDate(tariff.startDate);
          final endDate = AppDateFormatter.formatDate(tariff.endDate);

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiConstants.borderRadius),
              color: theme.colorScheme.secondary,
            ),
            child: ListTile(
              
              title: Text(
                tariff.tariff?.name ?? '',
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  date('from'.tr, startDate),
                  date('to'.tr, endDate),
                ],
              ),
            ),
          );
        }

        // Wrap content in DelayedLoader
        return DelayedLoader(
          isLoading: vm.isLoading,
          shimmer: shimmerWidget,
          child: contentWidget(),
          delay: const Duration(milliseconds: 500),
        );
      },
    );
  }
}