import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:self_utils/global/global.dart';
import 'package:self_utils/utils/api_exception.dart';
import 'package:self_utils/utils/toast_utils.dart';

import '../log_utils.dart';

class Request {
  // 配置 Dio 实例
  static final BaseOptions _options = BaseOptions(
    baseUrl: '',
    connectTimeout: 10000,
    receiveTimeout: 3000,
  );

  // 创建 Dio 实例
  static final Dio _dio = Dio(_options);

  // _request 是核心函数，所有的请求都会走这里
  static Future<Response> _request<T>(String path,
      {String? method, Map<String, dynamic>? params, data, String? token}) async {
    CookieJar cookie = CookieJar();
    _dio.interceptors.add(CookieManager(cookie));

    // restful 请求处理
    final Map<String, dynamic> headers = <String, dynamic>{};
    //一般情况下，未登陆前没token。
    if (token != null && token.isNotEmpty == true) {
      headers['Authorization'] = token;
    }

    //Fiddler抓包设置代理
    // if (GlobalStore.isUserFiddle == true) {
    //   setProxy();
    // }

    try {
      final Response response = await _dio.request(path,
          data: data ?? Object(),
          options: Options(method: method, headers: headers),
          queryParameters: params);

      if (response.statusCode == 200) {
        return response;
      } else {
        Log.info('HTTP错误，状态码为：${response.statusCode}');
        ToastUtils.showToast(msg: 'HTTP错误，状态码为${response.statusCode}');
        _handleHttpError(response.statusCode ?? 400);
        throw ApiException(response.statusCode ?? 400, response.statusMessage);
      }
    } on DioError catch (e, s) {
      Log.error('请求异常: ${_dioError(e)}', stackTrace: s);
      throw ApiException(e.response?.statusCode ?? 0, _dioError(e));
    } catch (e, s) {
      Log.error('未知异常: $e', stackTrace: s);
      rethrow;
    }
  }

  //设置抓包
  static void setProxy() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (Uri url) {
        return 'PROXY :8888';
      };
      //抓Https包设置
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };
  }

  // 处理 Dio 异常
  static String _dioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return '网络连接超时，请检查网络设置';
        break;
      case DioErrorType.receiveTimeout:
        return '服务器异常，请稍后重试！';
        break;
      case DioErrorType.sendTimeout:
        return '网络连接超时，请检查网络设置';
        break;
      case DioErrorType.response:
        return '服务器异常，请稍后重试！';
        break;
      case DioErrorType.cancel:
        return '请求已被取消，请重新请求';
        break;
      default:
        return "Dio异常";
    }
  }

  // 处理 Http 错误码
  static void _handleHttpError(int errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = '请求语法错误';
        break;
      case 401:
        message = '未授权，请登录';
        break;
      case 403:
        message = '拒绝访问';
        break;
      case 404:
        message = '请求出错';
        break;
      case 408:
        message = '请求超时';
        break;
      case 500:
        message = '服务器异常';
        break;
      case 501:
        message = '服务未实现';
        break;
      case 502:
        message = '网关错误';
        break;
      case 503:
        message = '服务不可用';
        break;
      case 504:
        message = '网关超时';
        break;
      case 505:
        message = 'HTTP版本不受支持';
        break;
      default:
        message = '请求失败，错误码：$errorCode';
    }
    ToastUtils.showToast(msg: message);
  }

  static Future<Response> get<T>(String path,
      {Map<String, dynamic>? params, String? token}) {
    return _request(path, method: 'get', params: params, token: token);
  }

  static Future<Response> post<T>(String path,
      {Map<String, dynamic>? params, data, String? token}) {
    return _request(path,
        method: 'post', params: params, data: data, token: token);
  }

  static Future<Response> downloadFile(String resUrl, String savePath,
      void Function(int loaded, int total) callBack) async {
    return await _dio.download(resUrl, savePath,
        onReceiveProgress: (int loaded, int total) {
      callBack.call(loaded, total);
    });
  }
}
