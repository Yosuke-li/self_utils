import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthorizationInterceptor extends Interceptor {
  bool beAuth;

  AuthorizationInterceptor({required this.beAuth});

  /*@override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    /// 定时刷新token
    if (response.statusCode == 401) {
      Dio _dio = DioHttpClient.getInstance()
          .getClient(response.requestOptions.baseUrl,);

      /// 锁住
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      /// 获取新的token
      PrettyHttp.post(
        "/api/login?terminal=WEB",
        beAuth: false,
        data: {"phone": "15896272531", "password": "111111"},
      ).then((value) {
        StoreUtils.store.write("user", value);
      }).whenComplete(() {

        _dio.
        _dio.unlock();
        PrettyHttp.http(
          response.requestOptions.method,
          response.requestOptions.path,
          data: response.requestOptions.data,
          reqParams: response.requestOptions.queryParameters,
        );
      });
    }
  }
*/
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
    if (beAuth) {
      //调接口
      options.headers['Authorization'] = '';
    } else {
      options.headers['Authorization'] = '';
    }
  }
}
