import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  // Patrón Singleton
  TokenStorage._internal();
  static final TokenStorage _instance = TokenStorage._internal();
  factory TokenStorage.getInstance() => _instance;

  static const String _key = 'access_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> save(String token) => _storage.write(key: _key, value: token);

  Future<String?> read() => _storage.read(key: _key);

  Future<void> delete() => _storage.delete(key: _key);
}