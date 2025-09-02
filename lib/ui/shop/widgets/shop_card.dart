import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/delete_show.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/shop/widgets/shop_edit.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shopModel;
  final int index;

  const ShopCard({
    super.key,
    required this.shopModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = context.watch<ShopViewmodel>();

    return Slidable(
      key: ValueKey(shopModel.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          Builder(
            builder: (cont) {
              return ElevatedButton(
                onPressed: () {
                  DeleteDialog.show(
                    context: context,
                    onConfirm: () => viewModel.deleteStore(shopModel.id!),
                    title: "shop_delete_title".tr,
                    description: "shop_delete_description".tr,
                  );
                  Slidable.of(cont)!.close();
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: theme.colorScheme.error,
                  padding: EdgeInsets.all(10),
                ),
                child: Icon(
                  Icons.delete,
                  color: theme.colorScheme.secondary,
                  size: 25,
                ),
              );
            },
          ),
          Builder(
            builder: (cont) {
              return ElevatedButton(
                onPressed: () {
                  ShopEditDialog.show(context, shopModel);
                  Slidable.of(cont)!.close();
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: theme.colorScheme.primary,
                  padding: EdgeInsets.all(10),
                ),
                child: Icon(
                  Icons.edit,
                  color: theme.colorScheme.secondary,
                  size: 25,
                ),
              );
            },
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () async {
          final selectStoreVM = context.read<SelectedStoreViewModel>();

          if (shopModel.id == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ Do‘kon ID mavjud emas")),
            );
            return;
          }

          // Store ID ni saqlash
          await selectStoreVM.saveStoreId(shopModel.id!);

          // 🔍 Konsolda tekshirish
          print("✅ Tanlangan storeId: ${selectStoreVM.storeId}");

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shopModel.storeName,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      shopModel.address,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: 600.ms,
              delay: (index * 200).ms,
            )
            .slideY(
              begin: 0.3,
              end: 0,
              duration: 600.ms,
              delay: (index * 200).ms,
            ),
      ),
    );
  }
}
