import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Footer({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFF751F),
      selectedItemColor: const Color(0xFF463521),
      unselectedItemColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Mis hobbies'),
        BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Mi secreto'),
      ],
    );
  }
}