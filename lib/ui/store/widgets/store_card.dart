import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/domain/models/store_model.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/routing/app_router.dart';
import 'package:provider/provider.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;
  final int index;

  const StoreCard({
    super.key,
    required this.store,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        final selectStoreVM = context.read<SelectedStoreViewModel>();

        // Store ID ni localga va providerga saqlash
        await selectStoreVM.saveStoreId(store.id!);
        
        // Home sahifaga o'tish
        Navigator.pushReplacementNamed(context, AppRouter.home);
      },
      child: Padding(
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
              )
            ],
          ),
          child: Row(
            children: [
              Image.asset('assets/icons/store.png', height: 36),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Matn chapga tekis
                children: [
                  Text(
                    store.storeName,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    store.address,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 600.ms, delay: (index * 200).ms).slideY(
          begin: 0.3, end: 0, duration: 600.ms, delay: (index * 200).ms),
    );
  }
}
