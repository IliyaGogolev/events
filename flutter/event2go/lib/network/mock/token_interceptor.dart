import 'dart:async';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  String? token;
  Stream<String?> onTokenChanged;

  TokenInterceptor({required this.onTokenChanged, this.token}) {
    this.onTokenChanged.listen((newToken) {
        this.token = newToken;
    });
  }

  void initializeToken(String savedToken) {
    token = savedToken;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer " + (token ?? "");
    super.onRequest(options, handler);
  }
}