class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._prefix, this._message]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super('Error during Communication', message);
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super('Invalid Request', message);
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super('Not Found', message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super('Unauthorized Request', message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super('Invalid Credentials', message);
}

// Firebase-specific custom exceptions
class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException([String? message])
      : super('Email already in use', message);
}

class InvalidEmailException extends AppException {
  InvalidEmailException([String? message]) : super('Invalid email', message);
}

class WeakPasswordException extends AppException {
  WeakPasswordException([String? message]) : super('Weak password', message);
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException([String? message])
      : super("Invalid credentials", message);
}

class UnknownFirebaseException extends AppException {
  UnknownFirebaseException([String? message]) : super('Unknown error', message);
}
