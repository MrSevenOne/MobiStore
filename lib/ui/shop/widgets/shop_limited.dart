import 'package:mobi_store/export.dart';

class ShopeLimitedWidget extends StatelessWidget {
  const ShopeLimitedWidget({super.key});

  static void show(BuildContext context) async {
    return showDialog(
      builder: (_) => ShopeLimitedWidget(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        'tariff_limit_title'.tr,
        style: theme.textTheme.titleMedium!
            .copyWith(color: theme.colorScheme.onPrimary),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'tariff_limit_subtitle'.tr,
        style: theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Burchaklarni yumaloqlash
            ),
          ),
          child: Text(
            'ok'.tr,
          ),
        )
      ],
    );
  }
}
