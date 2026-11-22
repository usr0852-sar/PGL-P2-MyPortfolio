import 'package:pgl_p2_myportfolio/services/http_service.dart';

class AuthService {
  // Patrón Singleton
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();
  factory AuthService.getInstance() => _instance;

  static const String _apiUrl = 'https://my-users-api.onrender.com/users';
  final HttpService _http = HttpService.getInstance();

  /// Registra un usuario y devuelve el mensaje de la API.
  Future<String> register({
    required String fullName,
    required String email,
    required String pwd,
  }) async {
    final data = await _http.post('$_apiUrl/register', {
      'fullName': fullName,
      'email': email,
      'pwd': pwd,
    });
    return data is Map
        ? data['message'] as String
        : 'Usuario registrado con éxito.';
  }
}