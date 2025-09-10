import 'package:flutter/cupertino.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/accessory/accessory_category_screen.dart';
import 'package:mobi_store/ui/accessory/widgets/accessory_add.dart';
import 'package:mobi_store/ui/phones/phones_page.dart';
import 'package:mobi_store/ui/phones/widgets/phone_add.dart';
import 'package:mobi_store/ui/reports/report_screen.dart';
import 'package:mobi_store/ui/setting/widgets/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Bottom sheet uchun callback funksiya
  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget body;

    switch (_currentIndex) {
      case 0:
        body = const PhonesPage();
        break;
      case 1:
        body = const AccessoryCategoryScreen(); // Tekshiruv olib tashlandi
        break;
      case 2:
        body = const ReportScreen();
        break;
      case 3:
        body = const AccessoryAddPage();
        break;
      case 4:
        body = const PhoneAddPage();
        break;
      case 5:
        body = const SettingScreen();
        break;
      default:
        body = const PhonesPage();
    }

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: false, // Faqat X button orqali yopiladi
            enableDrag: false, // Dragg qilish bilan yopilmaydi
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(UiConstants.borderRadius),
              ),
            ),
            builder: (context) {
              return AddItemBottomSheet(
                onNavigate: (index) {
                  Navigator.pop(context); // Bottom sheet ni yopish
                  _navigateToPage(index); // Sahifani o'zgartirish
                },
              );
            },
          );
        },
        child: Icon(CupertinoIcons.add, color: theme.colorScheme.secondary, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.house,
                    color: _currentIndex == 0
                        ? theme.colorScheme.primary
                        : theme.iconTheme.color),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
              IconButton(
                icon: Icon(CupertinoIcons.headphones,
                    color: _currentIndex == 1
                        ? theme.colorScheme.primary
                        : theme.iconTheme.color),
                onPressed: () => setState(() => _currentIndex = 1),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(CupertinoIcons.chart_pie,
                    color: _currentIndex == 2
                        ? theme.colorScheme.primary
                        : theme.iconTheme.color),
                onPressed: () => setState(() => _currentIndex = 2),
              ),
              IconButton(
                icon: Icon(CupertinoIcons.settings,
                    color: _currentIndex == 5
                        ? theme.colorScheme.primary
                        : theme.iconTheme.color),
                onPressed: () => setState(() => _currentIndex = 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Yangi alohida widget: AddItemBottomSheet
class AddItemBottomSheet extends StatelessWidget {
  final Function(int) onNavigate; // Callback sahifani o'zgartirish uchun

  const AddItemBottomSheet({
    super.key,
    required this.onNavigate,
  });

  // Aksessuar qo‘shish ruxsatini tekshirish va dialog ko‘rsatish
  Future<void> _checkAccessoryAccess(BuildContext context, int index) async {
    final userTariffVM = context.read<UserTariffViewModel>();
    final hasAccess = await userTariffVM.hasAccessoryAccess();
    final theme = Theme.of(context);

    if (hasAccess) {
      onNavigate(index); // Ruxsat bo‘lsa sahifaga o‘tish
    } else {
      // Ruxsat bo‘lmasa dialog ko‘rsatish
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: theme.colorScheme.secondary,
          title: Text(
            "no_permission".tr,
            style: theme.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          content: Text("no_accessory_permission_message".tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialogni yopish
                Navigator.pop(context); // Bottom sheet ni yopish
              },
              child: Text(
                "ok".tr,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: UiConstants.padding,
        horizontal: UiConstants.padding / 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Yuqoridagi X button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: theme.iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone_android, color: theme.colorScheme.primary),
            title: Text("add_phone_title".tr),
            onTap: () {
              onNavigate(4); // PhoneAddPage (index 4)
            },
          ),
          ListTile(
            leading: Icon(Icons.headphones, color: theme.colorScheme.primary),
            title: Text("add_accessory_title".tr),
            onTap: () {
              _checkAccessoryAccess(context, 3); // AccessoryAddPage (index 3) uchun tekshiruv
            },
          ),
        ],
      ),
    );
  }
}