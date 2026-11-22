import 'app_exception.dart';

class BadRequestException extends AppException { // 400 bad request
  BadRequestException([String? message])
      : super(message ?? 'Petición incorrecta.');
}