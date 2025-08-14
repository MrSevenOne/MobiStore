import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/theme_provider.dart';
import 'package:mobi_store/ui/provider/user_provider.dart';
import 'package:shimmer/shimmer.dart';

class DrawerHeaderSection extends StatefulWidget {
  const DrawerHeaderSection({super.key});

  @override
  State<DrawerHeaderSection> createState() => _DrawerHeaderSectionState();
}

class _DrawerHeaderSectionState extends State<DrawerHeaderSection> {
  @override
  void initState() {
    super.initState();
    final userId = UserManager.currentUserId;
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          context.read<UserViewModel>().fetchUserById(userId);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userVM = context.watch<UserViewModel>();
    final themeProvider = context.watch<ThemeViewModel>();

    // Yuklanish paytida shimmer bilan
    if (userVM.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            shimmerCircle(size: 56, isDark: themeProvider.isDarkMode),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerBox(
                    width: 120,
                    height: 16,
                    isDark: themeProvider.isDarkMode),
                const SizedBox(height: 8),
                shimmerBox(
                    width: 180,
                    height: 14,
                    isDark: themeProvider.isDarkMode),
              ],
            )
          ],
        ),
      );
    }

    if (userVM.error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Xatolik: ${userVM.error}'),
      );
    }

    final user = userVM.user;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: 
                 const AssetImage('assets/logo/user.png') as ImageProvider,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? "",
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: theme.colorScheme.onPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? "",
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.shadow),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// To‘rtburchak shimmer
  Widget shimmerBox({
    required double width,
    required double height,
    required bool isDark,
  }) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[600]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  /// Doira shaklidagi shimmer
  Widget shimmerCircle({
    required double size,
    required bool isDark,
  }) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[600]! : Colors.grey[100]!,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        ),
      ),
    );
  }
}
