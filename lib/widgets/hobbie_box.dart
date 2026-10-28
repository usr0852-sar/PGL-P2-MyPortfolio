import 'package:flutter/material.dart';

class HobbiesBox extends StatelessWidget {
  final String textasion;

  const HobbiesBox({super.key, required this.textasion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFFFF751F),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              textasion,
              style: const TextStyle(color: Color(0xFF463521), fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}