import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/welcome-flutter.jpg',
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BIENVENIDO A',
                        style: TextStyle(
                          color: Color(0xFF7ED957),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '¡ÉCHALE MOJO NIÑO!',
                        style: TextStyle(
                          color: Color(0xFFFF751F),
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Descubre, guarda y gestiona los platos típicos de Canarias',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF75675A),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SafeArea(
              top: false,
              child: Center(
                child: Builder(
                  builder: (context) => ElevatedButton.icon(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF751F),
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                    ),
                    label: const Text('EXPLORAR PLATOS'),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF7ED957),
                    ),
                    iconAlignment: IconAlignment.end,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}