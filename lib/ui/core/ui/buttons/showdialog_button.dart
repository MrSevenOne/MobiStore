import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DialogButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool isLoading;
  final String cancelText;
  final String submitText;

  const DialogButtons({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.isLoading = false,
    this.cancelText = 'Bekor qilish',
    this.submitText = 'Saqlash',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // ❌ Cancel Button
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: isLoading ? null : onCancel,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.shadow),
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.secondary,
              ),
              alignment: Alignment.center,
              child: Text(
                cancelText,
                style: theme.textTheme.bodySmall,
              ),
            ),
          )
              // ⬇️ Animate chiqish: fade + slide + sekin
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.3, end: 0, duration: 500.ms)
              .scaleXY(begin: 0.95, end: 1.0, duration: 500.ms),
        ),

        const SizedBox(width: 12),

        // ✅ Submit Button
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: isLoading ? null : onSubmit,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.secondary,
                      ),
                    )
                  : Text(
                      submitText,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.colorScheme.secondary),
                    ),
            ),
          )
              // ⬇️ Animate chiqish: fade + slide + sekin
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.3, end: 0, duration: 500.ms)
              .scaleXY(begin: 0.95, end: 1.0, duration: 500.ms),
        ),
      ],
    );
  }
}
