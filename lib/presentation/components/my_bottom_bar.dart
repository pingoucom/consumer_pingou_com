import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(.60),
      backgroundColor: Color(0xFFF6F0E7),
      selectedFontSize: 14,
      unselectedFontSize: 12,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 2,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        _buildBottomNavigationBarItem(Icons.home_outlined, 'Home', 0),
        _buildBottomNavigationBarItem(Icons.store_outlined, 'Loja', 1),
        _buildBottomNavigationBarItem(
            Icons.local_drink_outlined, 'Assinatura', 2),
        _buildBottomNavigationBarItem(Icons.menu_book_outlined, 'Pedidos', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          color:
              _selectedIndex == index ? Color(0xFFFAE287) : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 25,
        ),
      ),
      label: label,
    );
  }
}
