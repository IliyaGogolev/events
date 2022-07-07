import 'package:dio/dio.dart';

import 'endpoints.dart';

class DioClient {
// dio instance
  Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json;
  }

  // Future<Response<T>> get<T>(
  //     String path, {
  //       Map<String, dynamic> queryParameters,
  //       Options options,
  //       CancelToken cancelToken,
  //       ProgressCallback onReceiveProgress,
  //     }) {
  //   return _dio.get(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken,
  //       onReceiveProgress: onReceiveProgress);
  // }
}