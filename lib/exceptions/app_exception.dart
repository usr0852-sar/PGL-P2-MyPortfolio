class AppException implements Exception { // Clase base para todas las excepciones personalizadas de la aplicación
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}