import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:test_app/core/constants/contants.dart';
import 'package:test_app/enviroment.dart';

const TAG = 'BaseHttpClient';

class BaseHttpClient {
  static String authorizationHeader = 'Authorization';
  static String apiKey = 'api_key';
  static String apiKeyValue = '0351296ee277d494983dfba2a8f08652';

  static Dio createDioHttpClient() {
    final BaseOptions options = BaseOptions(
      baseUrl: Environment().config.apiHost,
    );
    Dio dio = Dio(options);

    dio.interceptors
      ..clear()
      ..add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ))
      ..add(
        InterceptorsWrapper(onRequest: (request, handler) async {
          request.queryParameters[apiKey] = apiKeyValue;
          handler.next(request);
        }, onError: (e, handler) async {
          if (e.response?.statusCode == HttpStatus.forbidden) {
            FlutterLogs.logInfo(TAG, API_TAG, 'Process: ${e.requestOptions.path.toString()}');
          } else {
            FlutterLogs.logError(TAG, API_TAG, 'Not forbidden error. ${e.toString()}');
            handler.next(e);
          }
        }),
      );

    return dio;
  }
}
