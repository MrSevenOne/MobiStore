import 'package:mobi_store/export.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  Future<void> _handleSignUp(AuthViewModel authViewModel) async {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        createdAt: DateTime.now(),
        status: false,
      );

      await authViewModel.signUp(user);
      Navigator.pushNamed(context, AppRouter.tariff);

      // if (authViewModel.errorMessage == null && mounted) {
      //   Navigator.pushNamed(context, AppRouter.company);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Column(
                    children: [
                      Text('create_account'.tr,
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.center),
                      SizedBox(height: 4),
                      Text('create_account_subtitle'.tr,
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(height: 40.0),

                  /// Name
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("user_name".tr,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.black)),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(hintText: 'name_hint'.tr),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "name_empty".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  /// Email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("email".tr,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.black)),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(hintText: 'email_hint'.tr),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "email_empty".tr;
                      }
                      final emailRegex =
                          RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                      if (!emailRegex.hasMatch(value.trim())) {
                        return "email_invalid".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  /// Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("password".tr,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.black)),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      hintText: "password_hint".tr,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "password_empty".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  /// Error message
                  if (authViewModel.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        authViewModel.errorMessage ?? "sign_up_error".tr,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  /// Sign Up button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authViewModel.isLoading
                          ? null
                          : () => _handleSignUp(authViewModel),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: authViewModel.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2)
                            : Text(
                                "sign_up".tr,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      /// Bottom prompt
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("have_account".tr, style: theme.textTheme.bodySmall),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.login),
            child: Text(
              "sign_in".tr,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
