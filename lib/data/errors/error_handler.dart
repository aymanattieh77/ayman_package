import 'dart:io';

import 'package:ayman_package/data/errors/exceptions.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  late ServerException exception;

  ErrorHandler.fromObject(dynamic error) {
    if (error is DioException) {
      exception = _handelError(error);
    } else if (error is SocketException) {
      exception = DataSource.noInternetConnection.getException();
    } else if (error is Response) {
      if (error.statusCode != null) {
        ErrorHandler.fromStatusCode(error.statusCode!);
      }
    } else {
      exception = DataSource.defaultError.getException();
    }
  }
  ErrorHandler.fromStatusCode(int statusCode) {
    if (statusCode >= 500 && statusCode < 599) {
      exception = DataSource.internalServerError.getException();
    } else if (statusCode == 400) {
      exception = DataSource.badRequset.getException();
    } else if (statusCode == 404) {
      exception = DataSource.notFound.getException();
    } else if (statusCode == 403) {
      exception = DataSource.forbidden.getException();
    } else if (statusCode == 401) {
      exception = DataSource.authroized.getException();
    } else if (statusCode == 409) {
      exception = DataSource.conflict.getException();
    } else if (statusCode == 408) {
      exception = DataSource.connectTimeout.getException();
    } else {
      exception = DataSource.defaultError.getException();
    }
  }
}

ServerException _handelError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getException();
    case DioExceptionType.receiveTimeout:
      return DataSource.recieveTimeout.getException();
    case DioExceptionType.unknown:
      return DataSource.defaultError.getException();
    case DioExceptionType.cancel:
      return DataSource.defaultError.getException();
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getException();
    case DioExceptionType.badCertificate:
      if (dioError.response != null &&
          dioError.response!.statusCode != null &&
          dioError.response!.statusMessage != null) {
        return ServerException(
            dioError.response!.statusMessage!, dioError.response!.statusCode!);
      } else {
        return DataSource.defaultError.getException();
      }

    case DioExceptionType.badResponse:
      if (dioError.response != null) {
        return ServerException(dioError.response!.data['message'], -1);
      }
      if (dioError.response!.statusCode != null &&
          dioError.response!.statusMessage != null) {
        return ServerException(
            dioError.response!.statusMessage!, dioError.response!.statusCode!);
      } else {
        return DataSource.defaultError.getException();
      }

    case DioExceptionType.connectionError:
      if (dioError.response != null &&
          dioError.response!.statusCode != null &&
          dioError.response!.statusMessage != null) {
        return ServerException(
            dioError.response!.statusMessage!, dioError.response!.statusCode!);
      } else {
        return DataSource.defaultError.getException();
      }
  }
}

enum DataSource {
  success,
  successNoContent,
  badRequset,
  forbidden,
  authroized,
  notFound,
  internalServerError,
  connectTimeout,
  conflict,
  recieveTimeout,
  sendTimeout,
  cahceError,
  noInternetConnection,
  defaultError
}

extension DataSourceExtension on DataSource {
  ServerException getException() {
    switch (this) {
      case DataSource.success:
        return ServerException(
            ResponsesMessages.success, ResponsesCode.success);
      case DataSource.successNoContent:
        return ServerException(
            ResponsesMessages.successNoContent, ResponsesCode.successNoContent);
      case DataSource.badRequset:
        return ServerException(
            ResponsesMessages.badRequset, ResponsesCode.badRequset);
      case DataSource.forbidden:
        return ServerException(
            ResponsesMessages.forbidden, ResponsesCode.forbidden);
      case DataSource.authroized:
        return ServerException(
            ResponsesMessages.authroized, ResponsesCode.authroized);
      case DataSource.notFound:
        return ServerException(
            ResponsesMessages.notFound, ResponsesCode.notFound);
      case DataSource.internalServerError:
        return ServerException(ResponsesMessages.internalServerError,
            ResponsesCode.internalServerError);
      case DataSource.connectTimeout:
        return ServerException(
            ResponsesMessages.connectTimeout, ResponsesCode.connectTimeout);
      case DataSource.conflict:
        return ServerException(
            ResponsesMessages.conflict, ResponsesCode.conflict);
      case DataSource.recieveTimeout:
        return ServerException(
            ResponsesMessages.recieveTimeout, ResponsesCode.recieveTimeout);
      case DataSource.sendTimeout:
        return ServerException(
            ResponsesMessages.sendTimeout, ResponsesCode.sendTimeout);
      case DataSource.cahceError:
        return ServerException(
            ResponsesMessages.cahceError, ResponsesCode.cahceError);
      case DataSource.noInternetConnection:
        return ServerException(ResponsesMessages.noInternetConnection,
            ResponsesCode.noInternetConnection);
      case DataSource.defaultError:
        return ServerException(
            ResponsesMessages.defaultError, ResponsesCode.defaultError);
    }
  }
}

class ResponsesCode {
  static const int success = 200; // success with data
  static const int successCreated = 201; // success created
  static const int successNoContent = 204; // success no content
  static const int badRequset = 400; // failure, API rejected requset
  static const int authroized = 401; // failure, user is not authroized
  static const int forbidden = 403; // failure, API rejected requset
  static const int methodNotAllowed = 405; // failure, API rejected requset
  static const int notFound = 404; // failure, not found
  static const int conflict = 409; // failure, conflict
  static const int requestTimeout = 408; // failure, requestTimeout
  static const int internalServerError = 500; // failure, crash in server side
  static const int badGateway = 502; // failure, crash in server side

  // local status code
  static const int connectTimeout = -1;
  static const int recieveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cahceError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponsesMessages {
  static const String success = "Success";
  static const String successNoContent = "success with not content";
  static const String badRequset = "Bad Request. try again later";
  static const String authroized = "User Unauthorized, try again later";
  static const String forbidden = "Forbidden Request. try again later";
  static const String internalServerError =
      "some thing went wrong, try again later";
  static const String notFound = "url not found, try again later";
  static const String conflict = "conflict found, try again later";

  // local status code
  static const String connectTimeout = "time out, try again late";
  static const String recieveTimeout = "time out, try again late";
  static const String sendTimeout = "time out, try again late";
  static const String cahceError = "cache error, try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
  static const String defaultError = "Something went wrong, try again later";
}

class APIInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
