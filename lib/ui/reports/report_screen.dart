import 'package:flutter/material.dart';
import 'package:mobi_store/ui/core/ui/show/date_picker_show.dart';
import 'package:mobi_store/ui/reports/widget/topSalePhone_card.dart';
import 'package:mobi_store/ui/reports/widget/total_price.dart';
import 'package:provider/provider.dart';
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
    vm = PhoneReportViewModel();
    vm.fetchReportsByShop("${shopId}");
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

          final chartData =
              vm.getProfitDataByDateRange(dateVm.range.start, dateVm.range.end);

          return Scaffold(
            appBar: AppBar(
              title: const Text("Telefon Daromad Reporti"),
              actions: [
                IconButton(
                  onPressed: () => _pickDateRange(dateVm),
                  icon: Icon(
                    Icons.date_range,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalPriceCard(),
                    const SizedBox(height: 12),
                    StatChartCard(),
                    const SizedBox(height: 12),
                   TopsalephoneCard(),
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
