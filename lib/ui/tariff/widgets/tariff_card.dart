import 'package:mobi_store/export.dart';

class TariffCard extends StatelessWidget {
  final TariffModel tariff;

  const TariffCard({
    super.key,
    required this.tariff,
    required Null Function() onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userTariffVM = context.watch<UserTariffViewModel>(); // Use watch to react to isLoading changes
    final userId = UserManager.currentUserId;

    Widget rowElement(String title) {
      return Row(
        children: [
          Image.asset('assets/icons/galochka.png'),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      );
    }

    Future<void> onBuyPressed() async {
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login first")),
        );
        return;
      }

      final success = await userTariffVM.buyTariff(
        userId: userId,
        tariff: tariff,
      );
      if (success == true) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, AppRouter.adminConnect);
      }
      debugPrint(success
          ? "Tariff successfully purchased"
          : "Error: ${userTariffVM.errorMessage}");
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            tariff.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F1E50),
            ),
          ),
          const Text(
            'Starting at',
            style: TextStyle(
              color: Color(0xFF858FAB),
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 28.0),

          /// Price
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${tariff.price} uzs',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                      fontSize: 32.0,
                    ),
                  ),
                  TextSpan(
                    text: " /${tariff.durationDays} days",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24.0),

          /// Buy button with loading state
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: userTariffVM.isLoading ? null : onBuyPressed, // Disable button when loading
              child: userTariffVM.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text("tariff_buy".tr), // Updated to use translation
            ),
          ),

          const SizedBox(height: 18.0),

          /// Description or features
          if (tariff.description?.isNotEmpty ?? false)
            rowElement(tariff.description!),

          rowElement('${tariff.storeAmount} store amount'),
          rowElement('Accessory: ${tariff.accessory ? "Yes" : "No"}'),
        ],
      ),
    );
  }
}