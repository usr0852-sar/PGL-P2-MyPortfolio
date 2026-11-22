import 'package:flutter/material.dart';
import 'package:pgl_p2_myportfolio/exceptions/app_exception.dart';
import 'package:pgl_p2_myportfolio/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombre = TextEditingController();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _auth = AuthService.getInstance();
  bool _cargando = false;
  String? _errNombre;
  String? _errEmail;
  String? _errPwd;

  @override
  void dispose() {
    _nombre.dispose();
    _email.dispose();
    _pwd.dispose();
    super.dispose();
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
    // Contraseña segura: 8+ caracteres, mayúscula, minúscula y número
  String? _errorPwd(String p) {
    if (p.length < 8) return 'Mínimo 8 caracteres';
    if (!p.contains(RegExp(r'[A-Z]'))) return 'Falta una mayúscula';
    if (!p.contains(RegExp(r'[a-z]'))) return 'Falta una minúscula';
    if (!p.contains(RegExp(r'[0-9]'))) return 'Falta un número';
    return null;
  }

  bool _validar() {
    final emailValido =
        RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(_email.text.trim());
    setState(() {
      _errNombre = _nombre.text.trim().length < 3 ? 'Mínimo 3 caracteres' : null;
      _errEmail = emailValido ? null : 'Email no válido';
      _errPwd = _errorPwd(_pwd.text);
    });
    return _errNombre == null && _errEmail == null && _errPwd == null;
  }

  Future<void> _registrar() async {
    if (!_validar()) return;
    setState(() => _cargando = true);
    try {
      final mensaje = await _auth.register(
        fullName: _nombre.text.trim(),
        email: _email.text.trim(),
        pwd: _pwd.text,
      );
      if (!mounted) return;
      await _alerta('Registro correcto', mensaje);
      if (!mounted) return;
      await _alerta('Registro correcto', mensaje);
      if (!mounted) return;
      context.go('/login');
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
      errorText: error,
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
              decoration: _decoracion('Nombre completo', Icons.person, _errNombre),
            ),
            const SizedBox(height: 16),
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
                onPressed: _cargando ? null : _registrar,
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
                    : const Text('REGISTRARSE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}