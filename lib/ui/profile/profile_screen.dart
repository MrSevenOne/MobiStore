import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/profile/widgets/edit_userinfo.dart';
import 'package:mobi_store/ui/provider/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  final UserViewModel viewModel = UserViewModel(UserService());

  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title:  Text("profile".tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UiConstants.padding),
          child: Column(
            spacing: 12.0,
            children: [
              GestureDetector(
                onTap: () {
                    EditUserinfoWidget.show(
                      context,
                    
                    );
                  
                },
                child: Container(
                  height: 70.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'edit_account'.tr,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
