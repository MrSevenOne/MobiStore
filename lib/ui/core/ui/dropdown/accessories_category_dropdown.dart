import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/accessory_category_viewmodel.dart';
import 'package:mobi_store/ui/provider/theme_provider.dart';

class CategoryDropdown extends StatefulWidget {
  final String? selectedCategoryId;
  final Function(String?) onChanged;

  const CategoryDropdown({
    Key? key,
    this.selectedCategoryId,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  void initState() {
    super.initState();
    final categoryVM =
        Provider.of<AccessoryCategoryViewModel>(context, listen: false);
    if (categoryVM.categories.isEmpty) {
      categoryVM.fetchCategories(); // serverdan yoki local db dan fetch
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeViewModel>();

    return Consumer<AccessoryCategoryViewModel>(
      builder: (context, categoryVM, _) {
        if (categoryVM.isLoading) {
          // Shimmer loading
          return Shimmer.fromColors(
            baseColor: themeProvider.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: themeProvider.isDarkMode ? Colors.grey[600]! : Colors.grey[100]!,
            child: Container(
              height: 55.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        }

        if (categoryVM.categories.isEmpty) {
          return Text("not_select_category".tr);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'category'.tr,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.colorScheme.onSecondary),
            ),
            const SizedBox(height: 6.0),
            DropdownButtonFormField<String>(
              value: widget.selectedCategoryId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              hint: Text(
                "enter_category".tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: theme.colorScheme.shadow,
                    fontSize: 14.0,
                  ),
                ),
              ),
              items: categoryVM.categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.id,
                  child: Text(
                    cat.name,
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
              validator: (value) =>
                  value == null || value.isEmpty ? 'select_category'.tr : null,
            ),
          ],
        );
      },
    );
  }
}
