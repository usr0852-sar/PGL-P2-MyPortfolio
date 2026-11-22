import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pgl_p2_myportfolio/exceptions/app_exception.dart';
import 'package:pgl_p2_myportfolio/exceptions/bad_request.dart';
import 'package:pgl_p2_myportfolio/exceptions/conflict_exception.dart';
import 'package:pgl_p2_myportfolio/exceptions/not_found.dart';
import 'package:pgl_p2_myportfolio/exceptions/server_exception.dart';
import 'package:pgl_p2_myportfolio/exceptions/unauthorized_exception.dart';

class HttpService {
  // Patrón Singleton
  HttpService._internal();
  static final HttpService _instance = HttpService._internal();
  factory HttpService.getInstance() => _instance;

  // Render puede tardar ~60 s en despertar
  static const Duration _timeout = Duration(seconds: 70);

  Map<String, String> _headers(String? token) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Future<dynamic> get(String url, {String? token}) {
    return _send(() => http.get(Uri.parse(url), headers: _headers(token)));
  }

  Future<dynamic> post(String url, Map<String, dynamic> data, {String? token}) {
    return _send(() => http.post(
          Uri.parse(url),
          headers: _headers(token),
          body: jsonEncode(data),
        ));
  }

  Future<dynamic> _send(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(_timeout);
      return _processResponse(response);
    } on TimeoutException {
      throw AppException('El servidor tardó demasiado en responder. Inténtalo de nuevo.');
    } on http.ClientException {
      throw AppException('Sin conexión a internet.');
    }
  }

  dynamic _processResponse(http.Response response) {
    
    dynamic body;
        print(response.body);
    try {
      body = jsonDecode(response.body);
    } catch (_) {
      body = null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) return body;

    // La API devuelve siempre {"message": "..."}
    final message = body is Map ? body['message'] as String? : null;

    switch (response.statusCode) {
      case 400:
        throw BadRequestException(message);
      case 401:
        throw UnauthorizedException(message);
      case 404:
        throw NotFoundException(message);
      case 409:
        throw ConflictException(message);
      default:
        throw ServerException(message);
    }
  }
}