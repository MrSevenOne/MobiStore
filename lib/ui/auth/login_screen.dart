import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi_store/ui/provider/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/routing/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  Future<void> _handleSignIn(AuthViewModel authViewModel) async {
    if (_formKey.currentState!.validate()) {
      await authViewModel.signIn(
          emailController.text.trim(), passwordController.text.trim());

      if (authViewModel.errorMessage == null && mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.splash);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                  /// Title texts
                  Column(
                    children: [
                      Text('sign_in_title'.tr,
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.center),
                      SizedBox(height: 4),
                      Text('sign_in_subtitle'.tr,
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(height: 50),

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
                    decoration: InputDecoration(hintText: "email_hint".tr),
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
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
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
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "password_empty".tr;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "recovery_password".tr,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 20),

                  /// Error message
                  if (authViewModel.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        authViewModel.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  /// Sign In button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authViewModel.isLoading
                          ? null
                          : () => _handleSignIn(authViewModel),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: authViewModel.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2)
                            : Text(
                                "sign_in".tr,
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

      /// Sign up prompt
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("dont_have_account".tr, style: theme.textTheme.bodySmall),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.signup),
            child: Text(
              "sign_up".tr,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
