import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/ui_constants.dart';
import 'package:mobi_store/domain/models/accessory_model.dart';
import 'package:mobi_store/domain/models/accessory_category_model.dart';
import 'package:mobi_store/ui/accessory/widgets/accessory_card.dart';
import 'package:mobi_store/ui/accessory/widgets/accessory_shimmercard.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:mobi_store/ui/provider/accessory_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:provider/provider.dart';

class AccessoriesScreen extends StatefulWidget {
  final AccessoryCategoryModel accessoryCategoryModel;
  const AccessoriesScreen({super.key, required this.accessoryCategoryModel});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final shopId = context.read<SelectedStoreViewModel>().storeId!;
      context
          .read<AccessoryViewModel>()
          .fetchAccessories(shopId, widget.accessoryCategoryModel.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccessoryViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.accessoryCategoryModel.name),
      ),
      body: DelayedLoader(
        isLoading: vm.isLoading,
        delay: const Duration(milliseconds: 600),

        // 🔹 Shimmer loader - list shaklida
        shimmer: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, __) => const AccessoryCardShimmer(),
        ),

        child: vm.errorMessage != null
            ? Center(child: Text(vm.errorMessage!))
            : vm.accessories.isEmpty
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Image.asset(
                          'assets/icons/emptyitem.png',
                          height: 200.0,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Hech qanday accessory topilmadi",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:  EdgeInsets.all(UiConstants.padding),
                    itemCount: vm.accessories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final acc = vm.accessories[index];
                      return Selector<AccessoryViewModel, AccessoryModel>(
                        selector: (_, provider) =>
                            provider.accessories.firstWhere(
                          (a) => a.id == acc.id,
                          orElse: () => acc,
                        ),
                        builder: (_, selectedAcc, __) {
                          return AccessoryCard(accessory: selectedAcc);
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
