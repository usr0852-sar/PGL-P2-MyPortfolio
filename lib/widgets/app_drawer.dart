import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final actual = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: const Color(0xFFFFF8F1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF7ED957)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xFFFF751F),
              child: Icon(Icons.person, size: 40, color: Colors.black),
            ),
            accountName: null,
            accountEmail: Text(
              'usr0852@lacuesta.salesianos.edu',
              style: TextStyle(color: Colors.white),
            ),
          ),
          _opcion(context, Icons.home, 'Inicio', '/', actual),
          _opcion(context, Icons.work, 'Portfolio', '/portfolio', actual),
        ],
      ),
    );
  }

  Widget _opcion(BuildContext context, IconData icono, String titulo,
      String ruta, String actual) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(icono),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        iconColor: const Color(0xFF463521),
        textColor: const Color(0xFF463521),
        selected: actual == ruta,
        selectedColor: const Color(0xFF00BF63),
        selectedTileColor: const Color(0xFF7ED957).withOpacity(0.3),
        shape: const StadiumBorder(),
        onTap: () => context.go(ruta),
      ),
    );
  }
}