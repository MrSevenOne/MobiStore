import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/provider/company_viewmodel.dart';
import 'package:mobi_store/ui/provider/theme_provider.dart';
import 'package:shimmer/shimmer.dart';

class CompanyDropdown extends StatefulWidget {
  final String? selectedCompanyId;
  final Function(String?) onChanged;

  const CompanyDropdown({
    Key? key,
    this.selectedCompanyId,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CompanyDropdown> createState() => _CompanyDropdownState();
}

class _CompanyDropdownState extends State<CompanyDropdown> {
  @override
  void initState() {
    super.initState();
    final companyVM = Provider.of<CompanyViewModel>(context, listen: false);
    if (companyVM.companies.isEmpty) {
      companyVM.fetchCompanies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
        final themeProvider = context.watch<ThemeViewModel>();

    return Consumer<CompanyViewModel>(
      builder: (context, companyVM, _) {
        if (companyVM.isLoading) {
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

        if (companyVM.companies.isEmpty) {
          return  Text("not_select_company".tr);
        }

        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'company'.tr,
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 6.0),
            DropdownButtonFormField<String>(
              value: widget.selectedCompanyId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              hint: Text(
                "enter_company".tr,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: theme.colorScheme.shadow,
                    fontSize: 14.0,
                  ),
                ),
              ),
              items: companyVM.companies.map((company) {
                return DropdownMenuItem<String>(
                  value: company.id,
                  child: Text(
                    company.name,
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
              validator: (value) =>
                  value == null || value.isEmpty ? 'select_company'.tr : null,
            ),
          ],
        );
      },
    );
  }
}
