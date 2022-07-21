import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  static const _jsonGetDir = 'assets/json';
  static const _jsonPostDir = 'assets/json/post';
  static const _jsonExtension = '.json';

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String jsonDir = _jsonGetDir;
    if (options.method == "POST") {
        jsonDir = _jsonPostDir;
    }

    final resourcePath = jsonDir + options.path + _jsonExtension;
    final jsonString = await rootBundle.load(resourcePath);
    final map = json.decode(
      utf8.decode(
        jsonString.buffer.asUint8List(jsonString.offsetInBytes, jsonString.lengthInBytes),
      ),
    );

    return Response(
      data: map,
      statusCode: 200,
    );
  }
}