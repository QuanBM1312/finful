
class ApiException implements Exception {
  final dynamic _data;

  ApiException(
      dynamic json, {
        String? prefix,
      }) : _data = json;

  dynamic get error => _data;
}

class FetchDataException extends ApiException {
  FetchDataException([super.error])
      : super(prefix: 'Error During Communication:');
}

class BadRequestException extends ApiException {
  BadRequestException([super.error])
      : super(prefix: 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([super.error])
      : super(prefix: 'Unauthorised: ');
}

class ForbiddenException extends ApiException {
  ForbiddenException([super.error]) : super(prefix: 'Forbidden: ');
}

class NotFoundException extends ApiException {
  NotFoundException([super.error]) : super(prefix: 'Not Found: ');
}

class ServerErrorException extends ApiException {
  ServerErrorException([super.error])
      : super(prefix: 'Server Error: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException([super.error])
      : super(prefix: 'Invalid Input: ');
}

class InvalidResponseException extends ApiException {
  InvalidResponseException([super.error])
      : super(prefix: 'Invalid Response: ');
}

class UnProcessableEntityException extends ApiException {
  UnProcessableEntityException([super.error])
      : super(prefix: 'UnProcessableEntity Request: ');
}

class PayloadTooLargeException extends ApiException {
  PayloadTooLargeException([super.error])
      : super(prefix: 'Payload Too Large: ');
}

class ValidationException extends ApiException {
  ValidationException([super.error]) : super(prefix: 'Validation: ');
}
