import 'app_exception.dart';

class ConflictException extends AppException { // 409 conflict
  ConflictException([String? message])
      : super(message ?? 'Conflicto con los datos enviados.');
}