import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:retrofit/dio.dart';
import 'package:test_app/core/constants/contants.dart';
import 'package:test_app/core/date_state.dart';
import 'package:test_app/data/models/remout/response/error_response.dart';


extension HttpResponseUtils on HttpResponse {
  DataFailed<T> formatErrorFromResponse<T>() {
    return DataFailed<T>(
      response.statusMessage ?? '',
      error: DioException(
        error: response.statusMessage,
        response: response,
        requestOptions: response.requestOptions,
      ),
    );
  }
}

extension ResponseUtils on Response {
  bool isSuccessful() {
    return 200 <= statusCode! && statusCode! < 300;
  }
}

Future<DataState<ReturnType>> doSafeApiCall<ReturnType, ResponseType>(
    Future<HttpResponse<ResponseType>> Function() apiCall,
    ReturnType Function(ResponseType responseData) mapResponse,
    {Function(ResponseType responseData)? extraSuccessAction}) async {
  try {
    final response = await apiCall();
    if (response.response.isSuccessful()) {
      if (extraSuccessAction != null) extraSuccessAction(response.data);
      return DataSuccess(mapResponse(response.data));
    }
    FlutterLogs.logError(API_TAG, 'Not success',
        '${response.response.statusCode} ${response.response.statusMessage}');
    return response.formatErrorFromResponse();
  } on DioException catch (e) {
    FlutterLogs.logError(API_TAG, 'Dio error', e.toString());
    if (e.response?.data != null && e.response!.data.toString().isNotEmpty) {
      dynamic errorJson;
      if (e.response?.data is String) {
        errorJson = json.decode(e.response!.data);
      } else {
        errorJson = e.response?.data;
      }
      return DataFailed(ErrorResponse.fromJson(errorJson).error.toString(), error: e);
    } else {
      return DataFailed(e.message, error: e);
    }
  } catch (e) {
    FlutterLogs.logError(API_TAG, 'Other error', e.toString());
    return DataFailed(e.toString());
  }
}

Future<DataState<ReturnType>> doSafeDbCall<ReturnType, ResponseType>(
    Future<ResponseType> Function() dbCall,
    ReturnType Function(ResponseType responseData) mapResponse) async {
  try {
    final responseData = await dbCall();
    return DataSuccess(mapResponse(responseData));
  } catch (e) {
    FlutterLogs.logError(DB_TAG, 'Database error', e.toString());
    return DataFailed('Error performing database operation: $e');
  }
}
