import 'dart:developer';

import 'package:ayman_package/data/api/endpoints.dart';
import 'package:ayman_package/data/errors/error_handler.dart';
import 'package:ayman_package/data/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioController {
  late Dio _dio;

  Dio get dio => _dio;
  DioController() {
    _initDio();
  }
  Map<String, dynamic> headers = {};
  _initDio() {
    final baseOptions = BaseOptions(
      headers: headers,
      baseUrl: Endpoints.baseUrl,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      contentType: "application/json",
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(baseOptions);

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
            requestBody: true, requestHeader: true, responseBody: false),
      );
    }
  }

  Future<Response<dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      throw ServerException(_catchError(e));
    }
  }

  Future<Response<dynamic>> post(String endpoint, {Object? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw ServerException(_catchError(e));
    }
  }

  Future<Response<dynamic>> put(String endpoint, {Object? data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      throw ServerException(_catchError(e));
    }
  }

  Future<Response<dynamic>> delete(String endpoint,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.delete(endpoint,
          data: data, queryParameters: queryParameters);
    } catch (e) {
      throw ServerException(_catchError(e));
    }
  }

  Future<Response<dynamic>> download(String url,
      {Object? savePath, Object? data}) async {
    try {
      return await _dio.download(url, savePath, data: data);
    } catch (e) {
      throw ServerException(_catchError(e));
    }
  }

  Future<Response<dynamic>> fetch(
      String baseUrl, String endpoint, String method,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      return await _dio.fetch(
        RequestOptions(
          baseUrl: baseUrl,
          headers: headers,
          data: data,
          path: endpoint,
          method: method,
          responseType: ResponseType.json,
          connectTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          contentType: "application/json",
          queryParameters: queryParameters,
          receiveDataWhenStatusError: true,
        ),
      );
    } catch (e) {
      throw ServerException(_catchError(e));
    }
  }

  String _catchError(e) {
    log(e.toString(), name: "Requset Error");
    return ErrorHandler.fromObject(e).exception.message;
  }
}
