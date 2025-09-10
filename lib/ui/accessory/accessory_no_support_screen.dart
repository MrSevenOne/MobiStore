import 'package:mobi_store/export.dart';

class AccessoryNoSupportScreen extends StatelessWidget {
  const AccessoryNoSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(UiConstants.padding),
        child: Center(
          child: Text(
            "no_accessory_permission_message".tr,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}