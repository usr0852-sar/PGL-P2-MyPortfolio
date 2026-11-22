import 'app_exception.dart';

class UnauthorizedException extends AppException { // 401 unauthorized
  UnauthorizedException([String? message])
      : super(message ?? 'No tiene permisos para esta petición.');
}