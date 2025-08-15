import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/routing/app_router.dart';
import 'package:mobi_store/ui/onboarding/widgets/button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Xush kelibsiz!",
      "subtitle": "Bizning mobil do'kon ilovamizga hush kelibsiz.",
      "image": "assets/onboarding/onboarding.png",
    },
    {
      "title": "Oson Savdo",
      "subtitle": "Mahsulotlarni osongina boshqaring va soting.",
      "image": "assets/onboarding/onboarding2.png",
    },
    {
      "title": "Tez Hisobotlar",
      "subtitle": "Daromadlaringizni kuzatib boring va nazorat qiling.",
      "image": "assets/onboarding/onboarding3.png",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed(AppRouter.login);
    }
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 5,
      width: _currentPage == index ? 35 : 15,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xFF5B9EE1) : Color(0xFFE5EEF7),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(data['image']!, height: 250)),
                      const SizedBox(height: 88),
                      Text(
                        data['title']!,
                        style: theme.textTheme.titleLarge
                      ),
                      const SizedBox(height: 8),
                      Text(data['subtitle']!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      List.generate(onboardingData.length, _buildIndicator),
                ),
                OnboardingButton(
                    title: _currentPage == onboardingData.length - 1
                        ? "start"
                        : "next",
                    ontap: _nextPage),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
