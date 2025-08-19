import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text("🏠 Home Page")),
    const Center(child: Text("❤️ Favorites Page")),
    const Center(child: Text("👜 Cart Page")),
    const Center(child: Text("🔔 Notifications Page")),
    const Center(child: Text("👤 Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // markazdagi tugma
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            _currentIndex = 2; // markaziy sahifa (Cart)
          });
        },
        child: const Icon(Icons.shopping_bag, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // pastki navigatsiya panel
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
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
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite,
                    color: _currentIndex == 1 ? Colors.blue : Colors.grey),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              const SizedBox(width: 40), // markaziy FAB uchun joy
              IconButton(
                icon: Icon(Icons.notifications,
                    color: _currentIndex == 3 ? Colors.blue : Colors.grey),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color: _currentIndex == 4 ? Colors.blue : Colors.grey),
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}