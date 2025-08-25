import 'package:flutter/material.dart';
import 'package:mobi_store/export.dart';
import 'package:mobi_store/ui/accessory/accessory_category_screen.dart';
import 'package:mobi_store/ui/accessory/widgets/accessory_add.dart';
import 'package:mobi_store/ui/core/ui/appBar/custom_appBar.dart';
import 'package:mobi_store/ui/core/ui/drawer/custom_drawer.dart';
import 'package:mobi_store/ui/phones/phones_page.dart';
import 'package:mobi_store/ui/phones/widgets/phone_add.dart';
import 'package:mobi_store/ui/reports/report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_currentIndex) {
      case 0:
        body = const PhonesPage();
        break;
      case 1:
        body = const AccessoryCategoryScreen();
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
      default:
        body = const PhonesPage();
    }

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
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
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text("Add Phone"),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentIndex = 4; // PhoneAddPage
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.headphones),
                      title: Text("Add Accessory"),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentIndex = 3; // AccessoryAddPage
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color: _currentIndex == 0 ? Colors.blue : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 0),
              ),
              IconButton(
                icon: Icon(Icons.favorite,
                    color: _currentIndex == 1 ? Colors.blue : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 1),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.notifications,
                    color: _currentIndex == 2 ? Colors.blue : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 2),
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color: _currentIndex == 3 ? Colors.blue : Colors.grey),
                onPressed: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
