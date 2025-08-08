import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/ui/company/widgets/company_add.dart';
import 'view_model/company_view_model.dart';

class CompanyScreen extends StatelessWidget {
  final CompanyViewModel viewModel;

  const CompanyScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            
            // Matnlar sekin paydo bo‘ladi
            Text(
              'store_title'.tr,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ).animate().fade(duration: 600.ms).scale(delay: 200.ms),

            const SizedBox(height: 4),

            Text(
              "store_subtitle".tr,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ).animate().fade(duration: 600.ms).scale(delay: 400.ms),

            // ListView animatsiyali
            Expanded(
              child: ListView.builder(
                itemCount: 3, // misol uchun 5 ta element
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(UiConstants.padding),
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: theme.colorScheme.shadow,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/store.png', height: 36),
                          const SizedBox(width: 24),
                          Text(
                            "O'zbegim N ${index + 1}",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                      // 🟡 Animatsiya: pastdan tepaga chiqish + sekin
                      .animate()
                      .fadeIn(duration: 600.ms, delay: (index * 200).ms)
                      .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: (index * 200).ms);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => StoreAddDialog.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
