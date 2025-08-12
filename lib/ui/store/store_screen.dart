import 'package:mobi_store/export.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      Future.microtask(() {
        context.read<StoreViewModel>().fetchStores();
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
              child: Consumer<StoreViewModel>(
                builder: (context, viewModel, _) {
                  viewModel.isLoading == true;
                  if (viewModel.isLoading) {
                    return ListView.builder(
                      itemCount:
                          3, // loading holatida nechta item chiqishini belgilash
                      itemBuilder: (context, index) => StoreShimmerCard(),
                    );
                  }
                  if (viewModel.stores.isEmpty) {
                    return const Center(
                        child: Text(
                      "Hali do‘kon qo‘shilmagan",
                      style: TextStyle(color: Colors.red),
                    ));
                  }
                  return ListView.builder(
                    itemCount: viewModel.stores.length,
                    itemBuilder: (context, index) {
                      return StoreCard(
                        store: viewModel.stores[index],
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
          final viewModel = context.read<StoreViewModel>();
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
            StoreAddDialog.show(context);
          } else {
            // Limit oshgan bo‘lsa ogohlantirish
            StoreLimitedWidget.show(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
