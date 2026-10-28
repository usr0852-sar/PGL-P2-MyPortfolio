import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SecretSection extends StatelessWidget {
  const SecretSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/chrome-firefox.jpeg",
          width: 140,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 10),
        const Text(
          "¡Lo siento pero don cangrejo es un npc y se queda con chrome, pero...!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFF463521),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        QrImageView(
          data: "https://youtu.be/rCbNf7kBcDs?si=wA4m6Os2TO6N2iq1",
          version: QrVersions.auto,
          size: 150.0,
          backgroundColor: Colors.deepOrange
        ),
      ],
    );
  }
}