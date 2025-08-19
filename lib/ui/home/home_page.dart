import 'package:flutter/material.dart';
import 'package:mobi_store/ui/phones/view_model/phones_page.dart';
import 'package:mobi_store/ui/phones/widgets/phone_add.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const PhonesPage(),
    const Center(child: Text("❤️ Favorites")),
    const Center(child: Text("🔔 Notifications")),
    const Center(child: Text("👤 Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        

        shape: const CircleBorder(
          
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PhoneAddPage()),
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
