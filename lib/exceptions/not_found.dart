import 'app_exception.dart';

class NotFoundException extends AppException { // 404 not found
  NotFoundException([String? message])
      : super(message ?? 'Recurso no encontrado.');
}