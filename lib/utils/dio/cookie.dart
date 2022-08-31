import 'package:dio/dio.dart';

class CookieManager extends Interceptor {
  CookieManager._privateConstructor();

  static final CookieManager _instance = CookieManager._privateConstructor();

  static CookieManager get instance => _instance;

  String? _cookie;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response != null) {
      if (response.statusCode == 200) {
        if (response.headers.map['set-cookie'] != null) {
          _cookie = response.headers.map['set-cookie']![0];
        }
      } else if (response.statusCode == 401) {
        _cookie = null;
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    options.headers['Cookie'] = _cookie;

    return super.onRequest(options, handler);
  }
}