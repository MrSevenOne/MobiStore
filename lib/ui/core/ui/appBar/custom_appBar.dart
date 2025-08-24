import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/ui/shop/view_model/shop_viewmodel.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final shopId = context.watch<SelectedStoreViewModel>().storeId;
    if (shopId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ShopViewmodel>().getShopInfo(shopId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Consumer<ShopViewmodel>(
        builder: (context, shopVM, child) {
          return DelayedLoader(
            isLoading: shopVM.isLoading,
            delay: const Duration(milliseconds: 500), // ⚡ 0.5s kutib keyin shimmer ko‘rsatadi
            shimmer: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                ShimmerBox(width: 80, height: 20),
                SizedBox(height: 4),
                ShimmerBox(width: 140, height: 20),
              ],
            ),
            child: shopVM.currentShop == null
                ? const Text("Do‘kon tanlanmagan")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        shopVM.currentShop!.address,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        shopVM.currentShop!.storeName,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.menu, size: 20),
          ),
        ),
      ),
      actions: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.face, size: 20),
        ),
      ],
    );
  }
}
