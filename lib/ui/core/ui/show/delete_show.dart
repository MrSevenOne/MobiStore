import 'package:flutter/material.dart';
import 'package:mobi_store/export.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String description;

  const DeleteDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.description,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onConfirm,
    required String title,
    required String description,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => DeleteDialog(
        onConfirm: onConfirm,
        title: title,
        description: description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          Image.asset('assets/icons/information.png', width: 30),
          const SizedBox(width: 12),
          Text(title, style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.onPrimary)),
        ],
      ),
      content: Text(
        description,
        style: theme.textTheme.bodySmall,
      ),
      actions: [
        Row(
          children: [
            // ❌ Cancel Button
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(8),
                  splashColor: theme.colorScheme.shadow,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      border: Border.all(color: theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0C101828),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'cancel'.tr,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 🗑️ Delete Button
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  borderRadius: BorderRadius.circular(8),
                  splashColor: theme.colorScheme.error,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      border: Border.all(color: theme.colorScheme.error),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0C101828),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child:  Center(
                      child: Text(
                        'delete'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
