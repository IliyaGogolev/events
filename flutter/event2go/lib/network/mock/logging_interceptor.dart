import 'dart:async';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        "--> ${options.method.toUpperCase()}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    handler.next(options);
  }

  @override
  void onError(DioError dioError,
      ErrorInterceptorHandler handler) {
    String? baseUrl = dioError.response?.requestOptions.baseUrl;
    String? path = dioError.response?.requestOptions.path;
    print(
        "<-- ${dioError.message} ${(baseUrl != null && path != null ? (baseUrl + path) : 'URL')}");
    print(
        "${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    print("<-- End error");
    handler.next(dioError);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String? baseUrl = response.requestOptions.baseUrl;
    String? path = response.requestOptions.path;
    print(
        "<-- ${response.statusCode} ${baseUrl + path}");
    print("Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
  }
}