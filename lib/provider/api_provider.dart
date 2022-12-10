import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

class ApiProvider {
  static final BaseOptions _options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: 30 * 1000, // 30 seconds
    receiveTimeout: 30 * 1000, // 30 seconds
    sendTimeout: 30 * 1000, // 30 seconds
  );
  static final Dio _dio = Dio(_options);

  //static const String base_url = 'http://192.168.8.217:3000';

  static Future<Response> get(String url, header) async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    //_dio.options.headers = header ?? {};
    String _url = '${url}';
    return await _dio.get(_url);
  }

  static Future<Response> post(url, data, header) async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String _url = '${url}';
    // _dio.options.headers = header ?? {};
    return await _dio.post(_url, data: data);
  }
}
