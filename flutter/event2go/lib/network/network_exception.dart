
class NetworkException implements Exception {

  const NetworkException(String error) : error = error;

  final String error;

  String get message => error;
}