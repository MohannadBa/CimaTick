import 'package:flutter/material.dart';
class MyB extends StatelessWidget {
  final int currentIndex;

  const MyB({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "/HomePage");
        break;
      case 1:
        Navigator.pushReplacementNamed(context, "/pastorder");
        break;
      case 2:
        Navigator.pushReplacementNamed(context, "/profile");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF3A7DCC),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.confirmation_num), label: "Tickets"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}
