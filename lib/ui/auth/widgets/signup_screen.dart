import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/routing/app_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title texts
                Column(
                  children: [
                    Text(
                      'create_account'.tr,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "create_account_subtitle".tr,
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                // TEXTFIELDs
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "user_name".tr,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  decoration: InputDecoration(hintText: 'name_hint'.tr),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "name_empty".tr;
                    }
                    final emailRegex =
                        RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                    if (!emailRegex.hasMatch(value.trim())) {
                      return "name_invalid".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "email".tr,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
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

                // Password field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "password".tr,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  // controller: passwordController,
                  obscureText: _obscureText,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
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
                SizedBox(height: 30.0),
                //Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "sign_up".tr,
                        style: theme.textTheme.bodyLarge!.copyWith(
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
      // Sign up prompt
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "have_account".tr,
            style: theme.textTheme.bodySmall!.copyWith(fontSize: 16.0),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.login),
            child: Text(
              "sign_in".tr,
              style: GoogleFonts.abhayaLibre(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
