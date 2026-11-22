import 'app_exception.dart';

class ServerException extends AppException { // 500 internal server error
  ServerException([String? message])
      : super(message ?? 'Error interno del servidor.');
}