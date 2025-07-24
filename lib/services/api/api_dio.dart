import 'package:deal_ping/constants/api_urls.dart';
import 'package:deal_ping/routes/app_routes.dart';
import 'package:deal_ping/services/storage/storage_service.dart';
import 'package:deal_ping/utils/app_log/app_log.dart';
import 'package:deal_ping/utils/app_log/error_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiDio {
  final Dio _dio = Dio();
  ApiDio._privateConstructor();
  static final ApiDio _instance = ApiDio._privateConstructor();
  static ApiDio get instance => _instance;
  ApiDio() {
    _dio.options.baseUrl = ApiUrls.baseUrl;
    _dio.options.sendTimeout = const Duration(seconds: 120);
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.options.followRedirects = false;

    _dio.interceptors.addAll({
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = ApiUrls.baseUrl;
          options.contentType = 'application/json';
          options.headers["Accept"] = "application/json";

          String token = LocalStorage.token;
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options); // Continue request
        },
        onError: (error, handler) async {
          appLog("API error occurred:");
          appLog("Status code: ${error.response?.statusCode}");
          appLog("Error message: ${error.message}");

          try {
            if (error.response?.statusCode == 401) {
              LocalStorage.token = "";
              Get.offAllNamed(AppRoutes.onboardingScreen);
              return handler.next(error);
            }
          } catch (e) {
            errorLog("error form api try and catch bloc $e");
            return handler.next(error);
          }

          return handler.next(error); // Continue with error
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(requestHeader: true, request: true, compact: true, error: true, requestBody: true, responseHeader: true, responseBody: true),
    });
  }
  Dio get sendRequest => _dio;
}