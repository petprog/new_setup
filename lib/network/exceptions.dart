class AppException implements Exception {
  final String message;
  final int? code;

  AppException({required this.message, this.code});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code});
}

class TimeoutException extends AppException {
  TimeoutException({required super.message, super.code});
}

class ServerException extends AppException {
  ServerException({required super.message, super.code});
}

class UnauthenticatedException extends AppException {
  UnauthenticatedException({required super.message, super.code});
}

class NotFoundException extends AppException {
  NotFoundException({required super.message, super.code});
}

class CancelException extends AppException {
  CancelException({required super.message, super.code});
}

class UnknownException extends AppException {
  UnknownException({required super.message, super.code});
}
