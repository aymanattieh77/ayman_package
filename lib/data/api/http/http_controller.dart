import 'dart:developer';
import 'dart:io';

import 'package:ayman_package/data/api/endpoints.dart';
import 'package:ayman_package/data/errors/error_handler.dart';
import 'package:ayman_package/data/errors/exceptions.dart';
import 'package:ayman_package/logs/logs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map<String, String> _headers = {
  "Accept": "application/json",
};

class HttpController {
  static Uri buildUri(String endpoint) {
    Uri uri;
    if (endpoint.startsWith("http")) {
      uri = Uri.parse(endpoint);
    } else {
      uri = Uri.parse(Endpoints.baseUrl + endpoint);
    }

    log(uri.toString(), name: "requset");
    return uri;
  }

  Future<http.Response> get(String endpoint, [qe]) async {
    try {
      final response = await http.get(buildUri(endpoint), headers: _headers);

      return _response(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint, [body]) async {
    try {
      final response =
          await http.post(buildUri(endpoint), body: body, headers: _headers);
      return _response(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<http.Response> delete(String endpoint, [body]) async {
    try {
      final response =
          await http.delete(buildUri(endpoint), body: body, headers: _headers);
      return _response(response);
    } catch (_) {
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint, [body]) async {
    try {
      final response =
          await http.put(buildUri(endpoint), body: body, headers: _headers);
      return _response(response);
    } catch (_) {
      rethrow;
    }
  }

  http.Response _response(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 299) {
      return response;
    } else {
      final errorMessage =
          ErrorHandler.fromStatusCode(response.statusCode).exception.message;
      logError(errorMessage);
      throw ServerException(errorMessage);
    }
  }
}

class ApiController {
  ApiController({
    this.token,
    this.lang,
    this.extraBody,
  });
  String? token;
  String? lang;
  Map<String, String>? extraBody;

  Map<String, String> headers = {
    "Accept": "application/json",
  };

  Future<void> addAuthHeaders({
    String? token,
  }) async {
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    // TODO
    // String lang = await CacheHelper.getData(key: CacheHelper.langKey) ??
    //     await LocaleService().getDeviceLanguage();

    headers['Accept-Language'] = lang;

    log("addAuthHeaders: $headers");
  }

  Future<dynamic> get(url) async {
    debugPrint('Api Get, url $url');
    dynamic responseJson;
    try {
      await addAuthHeaders(token: token);

      final response = await http.get(url, headers: headers);

      log('Get Data, headers: $headers');

      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> post(Uri url, body) async {
    debugPrint('Api Post, url $url');
    dynamic responseJson;
    try {
      debugPrint('Post data, $body');
      await addAuthHeaders(token: token);

      headers.addAll({
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'application/json; charset=utf-8',
      });

      final response = await http.post(url, body: body, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> postJson(url, Map<String, String> body) async {
    debugPrint('Api PostJson, url $url');
    dynamic responseJson;
    try {
      await addAuthHeaders(token: token);

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', url);
      request.body = json.encode(body);
      request.headers.addAll(headers);

      debugPrint('Post PostJson Data, url ${request.body}');

      http.StreamedResponse responseStreamed = await request.send().timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw InternetConnectionException(),
          );

      responseJson =
          _returnResponse(await http.Response.fromStream(responseStreamed));
    } on SocketException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> put(url, dynamic body) async {
    debugPrint('Api Put, url $url');
    http.Response responseJson;
    try {
      await addAuthHeaders(token: token);
      final response = await http.put(url, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> delete(url) async {
    debugPrint('Api delete, url $url');
    http.Response apiResponse;
    try {
      await addAuthHeaders(token: token);
      final response = await http.delete(url, headers: headers);
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw InternetConnectionException();
    }
    return apiResponse;
  }

  Future<dynamic> postMultipart(url, Map<String, String> body) async {
    debugPrint('Api Post Multipart, url $url');
    dynamic responseJson;
    try {
      await addAuthHeaders(token: token);
      var request = http.MultipartRequest('POST', url);

      if (extraBody != null) {
        request.fields.addAll(extraBody!);
      }

      headers.addAll({
        'Accept': 'application/json',
        'X-CSRF-TOKEN': '{csrf_token}',
      });

      request.fields.addAll(body);
      request.headers.addAll(headers);

      debugPrint('Post Multipart Headers, url ${request.headers}');
      debugPrint('Post Multipart Data, url ${request.fields}');

      http.StreamedResponse responseStreamed = await request.send().timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw InternetConnectionException(),
          );

      var res = await http.Response.fromStream(responseStreamed);

      responseJson = _returnResponse(res);
    } on SocketException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  Future<dynamic> postWithFile(
      url, Map<String, String> body, List<UploadFileHelper> files) async {
    debugPrint('Api Post, url $url');
    dynamic responseJson;
    try {
      await addAuthHeaders(token: token);
      var request = http.MultipartRequest('POST', url);
      if (extraBody != null) {
        request.fields.addAll(extraBody!);
      }
      for (var f in files) {
        final multipartFile = http.MultipartFile.fromBytes(
          f.fieldName,
          f.stream,
          filename: f.fileName,
        );
        log("multipartFile: ${multipartFile.filename}");
        request.files.add(multipartFile);
      }
      request.fields.addAll(body);
      request.headers.addAll(headers);

      debugPrint('Post WithFile Headers, url ${request.headers}');
      debugPrint('Post WithFile Files, url ${request.files}');
      debugPrint('Post WithFile Data, url ${request.fields}');
      http.StreamedResponse responseStreamed = await request.send().timeout(
            const Duration(seconds: 60),
            onTimeout: () => throw InternetConnectionException(),
          );
      responseJson =
          _returnResponse(await http.Response.fromStream(responseStreamed));
    } on SocketException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    final data =
        response.body == '' ? '' : json.decode(response.body.toString());
    switch (response.statusCode) {
      case 200:
        log("Response 200: $data");
        return data;
      case 201:
        log("Response 201: $data");
        return data;
      case 204:
        log("Response 204: $data");
        return data;
      case 400:
        log("Response 400: $data");
        throw BadRequestException(data);
      case 401:
        log("Response 401: $data");

        throw UnauthorisedException(data);
      case 403:
        log("Response 403: $data");
        throw UnauthorisedException(data);
      case 404:
        log("Response 404: $data");
        throw InvalidInputException(data);
      case 422:
        log("Response 422: $data");
        throw InvalidInputException(data);
      case 500:
        log("Response 500: $data");
        throw FetchDataException(data);
      default:
        throw FetchDataException(data);
    }
  }
}

class UploadFileHelper {
  final List<int> stream;
  String fieldName;
  final String? path;
  final String fileName;
  final int length;

  UploadFileHelper(this.stream, this.fileName, this.length, this.path,
      {this.fieldName = 'file'});

  String get lengthInMB {
    double sizeInMb = length / (1024 * 1024);
    return "${sizeInMb.toStringAsFixed(3)} MB";
  }
}
