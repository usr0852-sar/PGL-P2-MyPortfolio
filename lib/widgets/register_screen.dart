import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombre = TextEditingController();
  final _email = TextEditingController();
  final _pwd = TextEditingController();

  @override
  void dispose() {
    _nombre.dispose();
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  InputDecoration _decoracion(String label, IconData icono) {
    const marron = Color(0xFF463521);
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: marron),
      prefixIcon: Icon(icono, color: marron),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF7ED957), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFFF751F), width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7ED957),
        foregroundColor: const Color(0xFF463521),
        title: const Text(
          'Crear cuenta',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _nombre,
              decoration: _decoracion('Nombre completo', Icons.person),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: _decoracion('Email', Icons.email),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pwd,
              obscureText: true,
              decoration: _decoracion('Contraseña', Icons.lock),
            ),
          ],
        ),
      ),
    );
  }
}