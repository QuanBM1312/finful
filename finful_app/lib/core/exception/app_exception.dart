class AppException implements Exception {
  final String _message;

  AppException(String message) : _message = message;

  String get message => _message;
}

class BlocException extends AppException {
  BlocException(super.message);
}
