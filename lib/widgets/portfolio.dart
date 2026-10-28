import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'footer.dart';
import 'header.dart';
import 'hobbies_list.dart';
import 'secret_section.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  int opcionBody = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const Header(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              color: const Color(0xFF7ED957).withOpacity(0.4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      opcionBody == 0
                          ? 'assets/images/SpongeBob_SquarePants_character.png'
                          : 'assets/images/detective.jpg',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      opcionBody == 0
                          ? 'En la cartilla de hobbies podemos encontrar infinidad de cosas que le encantan a don cangrejo'
                          : '¡Zona secreta del Crustáceo Crujiente!',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: opcionBody == 0
                    ? HobbiesList() // <-
                    : const SecretSection(), // <-
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        currentIndex: opcionBody,
        onTap: (i) => setState(() => opcionBody = i),
      ),
    );
  }
}