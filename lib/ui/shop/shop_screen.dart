import 'package:mobi_store/export.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      Future.microtask(() {
        context.read<ShopViewmodel>().fetchStores();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(UiConstants.padding),
        child: Column(
          children: [
            const SizedBox(height: 100),
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
            ///////
            Expanded(
              child: Consumer<ShopViewmodel>(
                builder: (context, viewModel, _) {
                  viewModel.isLoading == true;
                  if (viewModel.isLoading) {
                    return ListView.builder(
                      itemCount:
                          3, // loading holatida nechta item chiqishini belgilash
                      itemBuilder: (context, index) => ShopShimmerCard(),
                    );
                  }
                  if (viewModel.stores.isEmpty) {
                    return Center(
                        child: Image.asset(
                      'assets/icons/emptyitem.png',
                      height: 200.0,
                    ));
                  }
                  return ListView.builder(
                    itemCount: viewModel.stores.length,
                    itemBuilder: (context, index) {
                      return ShopCard(
                        shopModel: viewModel.stores[index],
                        index: index,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final viewModel = context.read<ShopViewmodel>();
          final userId = Supabase.instance.client.auth.currentUser?.id;

          if (userId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Foydalanuvchi aniqlanmadi")),
            );
            return;
          }

          final canAdd = await viewModel.checkStoreLimit();

          if (canAdd == true) {
            // Limit ichida bo‘lsa dialog ochiladi
            // ignore: use_build_context_synchronously
            ShopAddDialog.show(context);
          } else {
            // Limit oshgan bo‘lsa ogohlantirish
            ShopeLimitedWidget.show(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
