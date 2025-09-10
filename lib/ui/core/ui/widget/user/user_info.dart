import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:mobi_store/ui/provider/user_provider.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoWidget> {
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

    // Shimmer UI using ShimmerBox
    Widget shimmerUI() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(UiConstants.borderRadius),
        ),
        child: Row(
          children: [
            ShimmerBox(
              height: 56,
              width: 56,
              radius: 28, // Circular avatar
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(
                  width: 120,
                  height: 16,
                  radius: 4,
                ),
                const SizedBox(height: 8),
                ShimmerBox(
                  width: 180,
                  height: 14,
                  radius: 4,
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Content UI (error or success)
    Widget contentUI() {
      if (userVM.error != null) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Xatolik: ${userVM.error}"),
        );
      }
      return _successUI(theme, userVM.user);
    }

    // Wrap in DelayedLoader
    return DelayedLoader(
      isLoading: userVM.isLoading,
      shimmer: shimmerUI(),
      child: contentUI(),
      delay: const Duration(milliseconds: 500),
    );
  }

  Widget _successUI(ThemeData theme, UserModel? user) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(UiConstants.borderRadius),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: const AssetImage('assets/logo/user.png'),
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
          const Spacer(),
          IconButton(
            onPressed: () {
              // edit profile page yoki dialog
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

}