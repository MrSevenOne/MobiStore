import 'package:flutter/material.dart';
import 'package:mobi_store/ui/provider/phone_report_view_model.dart';
import 'package:mobi_store/ui/provider/selectstore_viewmodel.dart';
import 'package:mobi_store/ui/reports/pages/phone_report/widget/phone_report_card.dart';
import 'package:provider/provider.dart';
import 'package:mobi_store/domain/models/phone_report_model.dart';

class PhoneReportScreen extends StatelessWidget {
  const PhoneReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reportVM = context.read<PhoneReportViewModel>();
    final shopId = context.read<SelectedStoreViewModel>().storeId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Phone Reports'),
      ),
      body: FutureBuilder<List<PhoneReportModel>>(
        future: reportVM.fetchReportsByShop(shopId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Xato: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Hali reportlar yo‘q"));
          }

          final reports = snapshot.data!;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            child: reports.length == 1
                // 🔹 faqat bitta bo‘lsa chap tomonda chiqadi
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 18,
                      child: Selector<PhoneReportViewModel, PhoneReportModel?>(
                        selector: (_, vm) => vm.reports.firstWhere(
                          (r) => r.id == reports.first.id,
                          orElse: () => reports.first,
                        ),
                        builder: (_, selectedReport, __) {
                          if (selectedReport == null) {
                            return const SizedBox.shrink();
                          }
                          return PhoneReportCard(report: selectedReport);
                        },
                      ),
                    ),
                  )
                // 🔹 ko‘p bo‘lsa Wrap ishlatiladi
                : Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: reports.map((report) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 18,
                        child: Selector<PhoneReportViewModel, PhoneReportModel?>(
                          selector: (_, vm) => vm.reports.firstWhere(
                            (r) => r.id == report.id,
                            orElse: () => report,
                          ),
                          builder: (_, selectedReport, __) {
                            if (selectedReport == null) {
                              return const SizedBox.shrink();
                            }
                            return PhoneReportCard(report: selectedReport);
                          },
                        ),
                      );
                    }).toList(),
                  ),
          );
        },
      ),
    );
  }
}
