import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/accessory/accessory_no_support_screen.dart';
import 'package:mobi_store/ui/core/ui/appBar/custom_appBar.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:mobi_store/ui/provider/accessory_category_viewmodel.dart';

class AccessoryCategoryScreen extends StatefulWidget {
  const AccessoryCategoryScreen({super.key});

  @override
  State<AccessoryCategoryScreen> createState() => _AccessoryCategoryScreenState();
}

class _AccessoryCategoryScreenState extends State<AccessoryCategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccessoryCategoryViewModel>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: FutureBuilder<bool>(
        future: context.read<UserTariffViewModel>().hasAccessoryAccess(),
        builder: (context, snapshot) {
          // Shimmer UI
          Widget shimmerUI() {
            return Padding(
              padding: EdgeInsets.all(UiConstants.padding),
              child: Column(
                children: [
                  ShimmerBox(
                    height: 24,
                    width: 150,
                    radius: 8,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ShimmerBox(
                          height: 80,
                          width: double.infinity,
                          radius: UiConstants.borderRadius,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // Content UI
          Widget contentUI() {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            if (snapshot.hasError) {
              return Center(child: Text("Xatolik: ${snapshot.error}".tr));
            }
            if (!snapshot.hasData || snapshot.data == false) {
              return const AccessoryNoSupportScreen();
            }

            return Consumer<AccessoryCategoryViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.errorMessage != null) {
                  return Center(child: Text(viewModel.errorMessage!.tr));
                }
                if (viewModel.categories.isEmpty) {
                  return Center(child: Text("Kategoriyalar topilmadi".tr));
                }

                return ListView.builder(
                  itemCount: viewModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = viewModel.categories[index];
                    final count = viewModel.categoryCounts[category.id] ?? 0;

                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: UiConstants.padding,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(UiConstants.borderRadius),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouter.accessories,
                          arguments: category,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/category.png',
                              height: 28,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              category.name,
                              style: theme.textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            Text(
                              "($count)",
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate()
                    .slideY(
                      begin: 0.5, // Pastdan boshlanadi
                      end: 0.0, // Normal holatga keladi
                      duration: 500.ms,
                      delay: (80 * index).ms, // Har bir element kechikish bilan paydo bo'ladi
                      curve: Curves.easeOut,
                    )
                    .fadeIn(
                      duration: 500.ms,
                      delay: (100 * index).ms, // Har bir element sekin paydo bo'ladi
                    );
                  },
                );
              },
            );
          }

          return DelayedLoader(
            isLoading: snapshot.connectionState == ConnectionState.waiting,
            shimmer: shimmerUI(),
            child: contentUI(),
            delay: const Duration(milliseconds: 500),
          );
        },
      ),
    );
  }
}