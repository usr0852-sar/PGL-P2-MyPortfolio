import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pgl_p2_myportfolio/exceptions/app_exception.dart';
import 'package:pgl_p2_myportfolio/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _auth = AuthService.getInstance();
  bool _cargando = false;
  String? _errEmail;
  String? _errPwd;

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }
    bool _validar() {
    final emailValido =
        RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(_email.text.trim());
    setState(() {
      _errEmail = emailValido ? null : 'Email no válido';
      _errPwd = _pwd.text.isEmpty ? 'Introduce la contraseña' : null;
    });
    return _errEmail == null && _errPwd == null;
  }

  Future<void> _alerta(String titulo, String mensaje) {
    return showDialog<void>(
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

  Future<void> _iniciarSesion() async {
    if (!_validar()) return;
    setState(() => _cargando = true);
    try {
      final respuesta = await _auth.login(
        email: _email.text.trim(),
        pwd: _pwd.text,
      );
      if (!mounted) return;
      await _alerta(
        'Sesión iniciada',
        '${respuesta.message}\n¡Hola, ${respuesta.user.fullName}!',
      );
      if (!mounted) return;
      context.go('/');
    } on AppException catch (e) {
      if (!mounted) return;
      await _alerta('Error', e.message);
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  InputDecoration _decoracion(String label, IconData icono, String? error) {
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
          'Iniciar sesión',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: _decoracion('Email', Icons.email, _errEmail),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pwd,
              obscureText: true,
              decoration: _decoracion('Contraseña', Icons.lock, _errPwd),
            ),
                        const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cargando ? null : _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF751F),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _cargando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('INICIAR SESIÓN'),
              ),
            ),
            const SizedBox(height: 12),
                      
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.push('/register'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF463521),
                  side: const BorderSide(color: Color(0xFF7ED957), width: 2),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('CREAR CUENTA'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}