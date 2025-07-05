import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:deal_ping/constants/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/api_response_model.dart';
import '../../utils/app_translation/app_static_key.dart';
import '../../utils/local_database/prefs_helper.dart';
import '../storage/storage_service.dart';

class ApiService {
  static final Dio _dio = getMyDio();

  static late Response bodyData;

  static Future<ApiResponseModel> postApi(String url, body,
      {Map<String, String>? header}) async {
    return requestApi(url, "POST", body: body, header: header);
  }

/*  static Future<ApiResponseModel> getApi(String url,
      {Map<String, String>? header}) async {
    return requestApi(url, "GET", header: header);
  }*/

  static Future<ApiResponseModel> getApi(
    String url, {
    Map<String, String>? header,
    Map<String, dynamic>? queryParams,
  }) async {
    return requestApi(url, "GET", header: header, queryParams: queryParams);
  }

  static Future<ApiResponseModel> putApi(String url,
      {Map<String, dynamic>? body, Map<String, String>? header}) async {
    return requestApi(url, "PUT", body: body, header: header);
  }

  static Future<ApiResponseModel> patchApi(String url,
      {body, Map<String, String>? header}) async {
    return requestApi(url, "PATCH", body: body, header: header);
  }

  static Future<ApiResponseModel> deleteApi(String url,
      {Map<String, dynamic>? body, Map<String, String>? header}) async {
    return requestApi(url, "DELETE", body: body, header: header);
  }

  static Future<ApiResponseModel> requestApi(
    String url,
    String method, {
    dynamic body,
    Map<String, String>? header,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await _dio.request(
        url,
        data: body,
        options: Options(method: method, headers: header),
        queryParameters: queryParams,
      );

      return handleResponse(response);
    } catch (e) {
      return handleError(e);
    }
  }

  static ApiResponseModel handleResponse(Response response) {
    if (response.statusCode == 201) {
      return ApiResponseModel(
          200, response.data['message'] ?? "", response.data);
    }

    return ApiResponseModel(response.statusCode ?? 500,
        response.data['message'] ?? "", response.data);
  }

  static ApiResponseModel handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        if (error.response?.statusCode == 502) {
          return ApiResponseModel(502, "bad Gateway", {});
        }

        if (error.response?.statusCode == 401) {
          PrefsHelper.removeAllPrefData();
          return ApiResponseModel(401, error.response?.data?['message'], {});
        }
      }
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return ApiResponseModel(408, AppStaticKey.requestTimeOut, {});
        case DioExceptionType.connectionError:
          return ApiResponseModel(503, AppStaticKey.noInternetConnection, {});
        default:
          return ApiResponseModel(
              error.response?.statusCode ?? 500,
              error.response?.data?['message'] ??
                  error.message ??
                  "Unknown Error",
              {});
      }
    } else if (error is SocketException) {
      return ApiResponseModel(503, AppStaticKey.noInternetConnection, {});
    } else if (error is FormatException) {
      return ApiResponseModel(
          400, AppStaticKey.badResponseRequest, bodyData.data);
    } else if (error is TimeoutException) {
      return ApiResponseModel(408, AppStaticKey.requestTimeOut, {});
    } else {
      return ApiResponseModel(400, error.toString(), {});
    }
  }
}

Dio getMyDio() {
  Dio dio = Dio();
  Stopwatch stopwatch = Stopwatch();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options
        ..headers["Authorization"] ??= "Bearer ${LocalStorage.token}"
        ..headers["Content-Type"] ??= "application/json"
        ..sendTimeout = const Duration(seconds: 30)
        ..receiveTimeout = const Duration(seconds: 30)
        ..baseUrl = options.baseUrl.startsWith("http") ? "" : ApiUrls.baseUrl
        ..extra["stopwatch"] = stopwatch;

      if (kDebugMode) {
        stopwatch.start();

        print(
            "Api Service==================>Requested URL:${options.method} ${options.uri}");
        print(
            "Api Service==================>Request Headers: ${options.headers}");

        if (options.headers["Content-Type"] == "application/json") {
          print(
              "Api Service==================>Request Body: ${jsonEncode(options.data)}");
        } else if (options.headers["Content-Type"] == "multipart/form-data") {
          if (options.data is FormData) {
            for (var entry in (options.data as FormData).files) {
              print("File Key: ${entry.key}, File MIME Type: ${entry.value}");
            }
          }
        }
      }
      handler.next(options);
    },
    onResponse: (response, handler) {
      if (kDebugMode) {
        stopwatch.stop();
        print(
            "Api Service==================>Response Time: ${stopwatch.elapsedMilliseconds / 1000} Second");
        print(
            "Api Service==================>Response Status Code: ${response.statusCode} ${response.requestOptions.uri}");
        print(
            "Api Service==================>Response Data: ${jsonEncode(response.data)}");
        stopwatch.reset();
      }
      handler.next(response);
    },
    onError: (error, handler) {
      if (kDebugMode) {
        stopwatch.stop();
        print(
            "Api Service==================>Response Time: ${stopwatch.elapsedMilliseconds / 1000} Second");
        print(
            "Api Service==================>Error Status Code: ${error.response?.statusCode} ${error.requestOptions.uri}");
        print(
            "Api Service==================>Error Data: ${jsonEncode(error.response?.data)}");
        stopwatch.reset();
      }
      handler.next(error);
    },
  ));
  return dio;
}
