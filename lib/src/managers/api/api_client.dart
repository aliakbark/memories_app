import 'dart:io';

import 'package:memories_app/src/managers/memories.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ApiClient {
  ApiClient() {
    initClient();
  }

  Dio _dio = Dio();

  void initClient() async {
    _dio = Dio(BaseOptions(
        baseUrl: Memories.baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 15000,
        followRedirects: true,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json,
          HttpHeaders.acceptHeader: ContentType.json,
        },
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true));

    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions reqOptions,
            RequestInterceptorHandler requestInterceptorHandler) {
      // Do something before request is sent
      return requestInterceptorHandler.next(reqOptions); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (Response<dynamic> response,
        ResponseInterceptorHandler responseInterceptorHandler) {
      // Do something with response data
      return responseInterceptorHandler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError:
        (DioError dioError, ErrorInterceptorHandler errorInterceptorHandle) {
      // Do something with response error
      return errorInterceptorHandle.next(dioError); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));

    _dio.interceptors.add(CookieManager(CookieJar()));
  }

  Dio get dio => _dio;

  Dio get authorizedDio {
    _dio.options.headers
        .addAll({'Authorization': ObjectFactory().prefs.getAuthToken});
    return _dio;
  }

  ///API URLs
  String apiUserLogin() => ''; // Method: POST

}
