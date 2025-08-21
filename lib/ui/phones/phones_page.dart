import 'package:mobi_store/domain/models/phone_model.dart';
import 'package:mobi_store/export.dart';
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

    // 🔍 Filterlangan list
    final filteredPhones = phoneVM.phones.where((phone) {
      final name = phone.modelName.toLowerCase();
      return name.contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "store_location".tr,
              style: theme.textTheme.bodySmall,
            ),
            SizedBox(height: 2),
            Text(
              "O'zbegim,71-do'kon",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.menu, size: 20.0),
            ),
          ),
        ),
        actions: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.face, size: 20.0),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => PhoneAddWidget.show(context),
      //   child: const Icon(Icons.add),
      // ),
      body: Column(
        children: [
          // Search bar
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
              child: phoneVM.isLoading
                  ? SingleChildScrollView(
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
                    )
                  : phoneVM.errorMessage != null
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
                                  SizedBox(height: 8.0),
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
                                  // 🔹 faqat bitta bo‘lsa chap tomonga chiqadi
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                18,
                                        child: PhoneCard(
                                            phone: filteredPhones.first),
                                      ),
                                    )
                                  // 🔹 ko‘p bo‘lsa Wrap ishlatiladi
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
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              18,
                                          child: Selector<PhoneViewModel,
                                              PhoneModel>(
                                            selector: (_, vm) =>
                                                vm.phones.firstWhere(
                                              (p) => p.id == phone.id,
                                              orElse: () => phone,
                                            ),
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
        ],
      ),
    );
  }
}
