import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_store/routing/app_router.dart';
import '../view_model/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  final SplashViewModel viewModel;

  const SplashScreen({super.key, required this.viewModel});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await widget.viewModel.handleStartupLogic();

    // Delay for splash duration
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final targetRoute = widget.viewModel.targetRoute ?? AppRouter.login;

    Navigator.of(context).pushReplacementNamed(targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 250,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Mobi",
                  style: GoogleFonts.inknutAntiqua(
                    textStyle: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                Text(
                  "Store",
                  style: GoogleFonts.inknutAntiqua(
                    textStyle: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
