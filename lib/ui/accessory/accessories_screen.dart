import 'package:flutter/material.dart';
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
        shimmer: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 18,
                child: const AccessoryCardShimmer(),
              ),
            ),
          ),
        ),
        child: vm.errorMessage != null
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(child: Text(vm.errorMessage!)),
              )
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
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    child: vm.accessories.length == 1
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 18,
                              child: AccessoryCard(
                                  accessory: vm.accessories.first),
                            ),
                          )
                        : Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: vm.accessories.map((acc) {
                              return SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 18,
                                child: Selector<AccessoryViewModel,
                                    AccessoryModel>(
                                  selector: (_, provider) =>
                                      provider.accessories.firstWhere(
                                    (a) => a.id == acc.id,
                                    orElse: () => acc,
                                  ),
                                  builder: (_, selectedAcc, __) {
                                    return AccessoryCard(
                                        accessory: selectedAcc);
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                  ),
      ),
    );
  }
}
