import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/appBar/custom_appBar.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:mobi_store/ui/provider/accessory_category_viewmodel.dart';

class AccessoryCategoryScreen extends StatefulWidget {
  const AccessoryCategoryScreen({super.key});

  @override
  State<AccessoryCategoryScreen> createState() =>
      _AccessoryCategoryScreenState();
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
      body: Consumer<AccessoryCategoryViewModel>(
        builder: (context, viewModel, child) {
          // Loading indicator
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error ko‘rsatish
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          // Hech qanday category yo‘q
          if (viewModel.categories.isEmpty) {
            return const Center(child: Text("Kategoriyalar topilmadi"));
          }

          // List
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
                padding: EdgeInsets.all(16.0),
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
                      const Spacer(),
                      Text(
                        "($count)",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
