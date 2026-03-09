/// Base Exception class
class AppException implements Exception {
  final String message;
  final String? code;
  const AppException(this.message, {this.code});

  @override
  String toString() => message;
}

/// Server Exception
class ServerException extends AppException {
  const ServerException(super.message, {super.code});
}

/// Network Exception
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}

/// Cache Exception
class CacheException extends AppException {
  const CacheException(super.message, {super.code});
}

/// Validation Exception
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}

/// Unknown Exception
class UnknownException extends AppException {
  const UnknownException(super.message, {super.code});
}
