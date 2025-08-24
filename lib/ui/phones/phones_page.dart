import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/appBar/custom_appBar.dart';
import 'package:mobi_store/ui/core/ui/delayedLoader.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:mobi_store/ui/core/ui/searchbar/phone_search.dart';
import 'package:mobi_store/ui/phones/widgets/phone_add.dart';
import 'package:mobi_store/ui/phones/widgets/phonecard_shimmer.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/provider/phone_viewmodel.dart';
import 'package:mobi_store/ui/phones/widgets/phone_card.dart';


class PhonesPage extends StatefulWidget {
  const PhonesPage({super.key});

  @override
  State<PhonesPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PhonesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final storeId = context.read<SelectedStoreViewModel>().storeId;
      if (storeId != null) {
        context.read<PhoneViewModel>().fetchPhonesByShop(storeId.toString());
      } else {
        context.read<PhoneViewModel>().fetchPhones();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final phoneVM = context.watch<PhoneViewModel>();
    final theme = Theme.of(context);

    final filteredPhones = phoneVM.phones.where((phone) {
      final name = phone.modelName.toLowerCase();
      return name.contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // 🔍 Search bar
          PhoneSearchBar(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
          ),

          // 📱 Scroll qism
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final storeId = context.read<SelectedStoreViewModel>().storeId;
                if (storeId != null) {
                  await context
                      .read<PhoneViewModel>()
                      .fetchPhonesByShop(storeId.toString());
                } else {
                  await context.read<PhoneViewModel>().fetchPhones();
                }
              },
              child: DelayedLoader(
                isLoading: phoneVM.isLoading,
                delay: const Duration(milliseconds: 600), // ⚡ shimmerni kechiktiramiz
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
                        child: const PhoneCardShimmer(),
                      ),
                    ),
                  ),
                ),
                child: phoneVM.errorMessage != null
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Center(child: Text(phoneVM.errorMessage!)),
                      )
                    : filteredPhones.isEmpty
                        ? SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.2,
                                ),
                                Image.asset(
                                  'assets/icons/emptyitem.png',
                                  height: 200.0,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "add_press".tr,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(12),
                            child: filteredPhones.length == 1
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2 -
                                              18,
                                      child: PhoneCard(
                                          phone: filteredPhones.first),
                                    ),
                                  )
                                : Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: filteredPhones.map((phone) {
                                      if (phone.id == null) {
                                        debugPrint(
                                            "Xato: Telefon ID null - ${phone.modelName}");
                                        return const SizedBox.shrink();
                                      }
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                18,
                                        child: Selector<PhoneViewModel,
                                            PhoneModel>(
                                          selector: (_, vm) => vm.phones
                                              .firstWhere(
                                                  (p) => p.id == phone.id,
                                                  orElse: () => phone),
                                          builder: (_, selectedPhone, __) {
                                            return PhoneCard(
                                                phone: selectedPhone);
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
