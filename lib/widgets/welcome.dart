import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'package:pgl_p2_myportfolio/exceptions/app_exception.dart';
import 'package:pgl_p2_myportfolio/services/auth_service.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

    Future<void> _saludar(BuildContext context) async {
    String titulo = 'Bienvenida';
    String mensaje;
    try {
      mensaje = await AuthService.getInstance().getWelcomeMessage();
    } on AppException catch (e) {
      titulo = 'Error';
      mensaje = e.message;
    }
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFF8F1),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF463521),
          ),
        ),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
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
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
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
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () => _saludar(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFF7ED957),
                            width: 2,
                          ),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                        ),
                        child: const Text('MENSAJE DE BIENVENIDA'),
                      ),
                    ],
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