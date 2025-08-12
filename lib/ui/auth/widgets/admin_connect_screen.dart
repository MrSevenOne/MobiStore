import 'package:mobi_store/export.dart';

class AdminConnectScreen extends StatelessWidget {
  const AdminConnectScreen({super.key});

  // Function to launch Telegram URL
  Future<void> _launchTelegram() async {
    const String telegramUrl = 'https://t.me/Mr_sevenOne'; // Replace with actual Telegram link
    final Uri url = Uri.parse(telegramUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $telegramUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'admin_c_title'.tr, // Example: "Contact Admin"
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'admin_c_subtitle'.tr, // Example: "Reach out to confirm your tariff"
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchTelegram,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: theme.textTheme.labelLarge,
              ),
              child: Text('contact_admin'.tr,
              ), // Example: "Open Telegram"
            ),
          ],
        ),
      ),
    );
  }
}