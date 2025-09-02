import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/tariff/widgets/tariff_card_shimmer.dart';

class TariffScreen extends StatefulWidget {
  const TariffScreen({super.key});

  @override
  State<TariffScreen> createState() => _TariffScreenState();
}

class _TariffScreenState extends State<TariffScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TariffViewModel>().fetchTariffs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tariffVM = context.watch<TariffViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Title
            Column(
              children: [
                Text(
                  'tariff_title'.tr,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'tariff_subtitle'.tr,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Loading / Error / Slider
            if (tariffVM.isLoading)
              CarouselSlider.builder(
                itemCount: 4,
                itemBuilder: (context, index, realIndex) {
                  return TariffCardShimmer();
                },
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              )
            else if (tariffVM.errorMessage != null)
              Text(
                tariffVM.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (tariffVM.tariffs.isEmpty)
              const Text("No tariffs found")
            else
              CarouselSlider.builder(
                itemCount: tariffVM.tariffs.length,
                itemBuilder: (context, index, realIndex) {
                  final tariff = tariffVM.tariffs[index];
                  return TariffCard(
                    tariff: tariff,
                    onBuy: () {
                      debugPrint("Buying tariff: ${tariff.name}");
                    },
                  );
                },
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
