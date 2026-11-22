import 'package:pgl_p2_myportfolio/services/http_service.dart';
import 'package:pgl_p2_myportfolio/models/login_response.dart';
import 'package:pgl_p2_myportfolio/services/token_storage.dart';
import 'package:pgl_p2_myportfolio/exceptions/unauthorized_exception.dart';

class AuthService {
  // Patrón Singleton
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();
  factory AuthService.getInstance() => _instance;

  static const String _apiUrl = 'https://my-users-api.onrender.com/users';
  final HttpService _http = HttpService.getInstance();
  final TokenStorage _tokenStorage = TokenStorage.getInstance();

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
    /// Inicia sesión y devuelve un objeto con mensaje, token y usuario.
    Future<LoginResponse> login({
    required String email,
    required String pwd,
  }) async {
    final data = await _http.post('$_apiUrl/login', {
      'email': email,
      'pwd': pwd,
    });
    final respuesta = LoginResponse.fromJson(data as Map<String, dynamic>);
    await _tokenStorage.save(respuesta.token);
    return respuesta;
  }
    /// ¿Hay un token guardado y sigue siendo válido en la API?
  Future<bool> hasValidSession() async {
    final token = await _tokenStorage.read();
    if (token == null) return false;
    try {
      await _http.get('$_apiUrl/check-token', token: token);
      return true;
    } on UnauthorizedException {
      await _tokenStorage.delete(); // token caducado o inválido
      return false;
    }
  }
}