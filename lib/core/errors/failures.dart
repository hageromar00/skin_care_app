/// Base Failure class for handling errors
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Input validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Unknown failures
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
