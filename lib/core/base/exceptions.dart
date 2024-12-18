// Custom exceptions for better error handling
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>> errors;
  ValidationException(this.message, this.errors);
}

class ServerException implements Exception {
  final String message;
  final int statusCode;
  ServerException(this.message, this.statusCode);
}
