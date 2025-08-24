import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/appBar/custom_appBar.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:mobi_store/ui/provider/accessory_category_viewmodel.dart';

class AccessoryCategoryScreen extends StatelessWidget {
  const AccessoryCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<AccessoryCategoryViewModel>(context, listen: false);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: viewModel.fetchCategories(), // ma’lumotni olish
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // yuklanmoqda
          } else if (snapshot.hasError) {
            return Center(child: Text("Xatolik: ${snapshot.error}"));
          } else {
            return Consumer<AccessoryCategoryViewModel>(
              builder: (context, viewmodel, child) {
                if (viewmodel.categories.isEmpty) {
                  return const Center(child: Text("Kategoriyalar topilmadi"));
                }
                return ListView.builder(
                  itemCount: viewmodel.categories.length,
                  itemBuilder: (context, index) {
                    final category = viewmodel.categories[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: UiConstants.padding,
                      ),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius:
                            BorderRadius.circular(UiConstants.borderRadius),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouter.accessories,
                          arguments: category,
                        ),
                        child: Row(
                          spacing: 12.0,
                          children: [
                            Image.asset(
                              'assets/icons/category.png',
                              height: 28,
                            ),
                            Text(
                              category.name,
                              style: theme.textTheme.bodyLarge,
                            ),
                            Spacer(),
                            Text(
                              "(${viewmodel.categoryCounts[category.id] ?? 0})",
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
