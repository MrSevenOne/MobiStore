import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/core/ui/show/date_picker_show.dart';
import 'package:mobi_store/ui/provider/accessory_report_viewmodel.dart';
import 'package:mobi_store/ui/reports/widget/total_card.dart';
import 'package:mobi_store/ui/reports/widget/total_price.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/reports/widget/chart_card.dart';
import 'package:mobi_store/ui/provider/daterange_viewmodel.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late PhoneReportViewModel vm;

  @override
  void initState() {
    super.initState();
    final shopId = context.read<SelectedStoreViewModel>().storeId;

    vm = PhoneReportViewModel(shopId: shopId!);
    vm.fetchReportsByShop(shopId);
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange(DaterangeViewmodel dateVm) async {
    final result =
        await DateRangePickerWidget.show(context, initialRange: dateVm.range);
    if (result != null) {
      dateVm.setRange(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: vm),
        ChangeNotifierProvider(create: (_) => DaterangeViewmodel()),
      ],
      child: Consumer2<PhoneReportViewModel, DaterangeViewmodel>(
        builder: (context, vm, dateVm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text(vm.errorMessage!));
          }

          vm.getProfitDataByDateRange(dateVm.range.start, dateVm.range.end);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("report_title".tr),
              actions: [
                IconButton(
                  onPressed: () => _pickDateRange(dateVm),
                  icon: Icon(
                    Icons.date_range,
                  ),
                ),
              ],
            ),
            // drawer: CustomDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.0,
                  children: [
                    TotalPriceCard(),
                    Row(
                      children: [
                        Expanded(
                          child: TotalCard<PhoneReportViewModel>(
                            title: "total_phones".tr,
                            getTotal: (vm, start, end) =>
                                vm.getTotalProfitByDateRange(start, end),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 🔹 Accessory uchun ruxsat tekshiruv
                        Expanded(
                          child: FutureBuilder<bool>(
                            future: context
                                .read<UserTariffViewModel>()
                                .hasAccessoryAccess(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError || snapshot.data == false) {
                                return SizedBox();
                              }
                              return TotalCard<AccessoryReportViewModel>(
                                title: "total_accessories".tr,
                                getTotal: (vm, start, end) =>
                                    vm.getTotalProfitByDateRange(start, end),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    StatChartCard<PhoneReportViewModel>(
                      title: "phone_profit_chart".tr,
                      getData: (vm, start, end) =>
                          vm.getProfitDataByDateRange(start, end),
                    ),

                    // 🔹 Accessory chart ruxsatga qarab
                    FutureBuilder<bool>(
                      future: context
                          .read<UserTariffViewModel>()
                          .hasAccessoryAccess(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError || snapshot.data == false) {
                          return SizedBox();
                        }
                        return StatChartCard<AccessoryReportViewModel>(
                          title: "accessory_profit_chart".tr,
                          getData: (vm, start, end) =>
                              vm.getProfitDataByDateRange(start, end),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
