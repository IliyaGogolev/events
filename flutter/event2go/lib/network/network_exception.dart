
class NetworkException implements Exception {
  NetworkException(String errorMessage);

  String error;

  String get message => (error?.toString() ?? '');
}