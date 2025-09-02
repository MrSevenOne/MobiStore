import 'package:mobi_store/export.dart';

class AdminConnectScreen extends StatelessWidget {
  // Function to launch Telegram URL
  Future<void> _launchTelegram() async {
    const String telegramUrl =
        'https://t.me/Mr_sevenOne'; // Replace with actual Telegram link
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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F1E50), Color(0xFF2D3E7B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Telegram icon/avatar
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Image.asset(
                        "assets/icons/telegram.png", // add telegram logo in assets
                        height: 60.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Title
                  Text(
                    'admin_c_title'.tr, // Example: "Contact Admin"
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  /// Subtitle
                  Text(
                    'admin_c_subtitle'
                        .tr, // Example: "Reach out to confirm your tariff"
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  /// Contact Admin button
                  ElevatedButton.icon(
                    onPressed: _launchTelegram,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.telegram, color: Colors.white),
                    label: Text(
                      'kontakt admin',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
