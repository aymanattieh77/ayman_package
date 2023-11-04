import 'dart:developer';
import 'dart:io';

import 'package:ayman_package/data/errors/error_handler.dart';
import 'package:ayman_package/data/errors/exceptions.dart';
import 'package:http/http.dart' as http;

handleError() async {
  try {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/postss"));

    if (response.statusCode != 200) {
      log(response.statusCode.toString());

      throw response.statusCode;
    }
  } on SocketException catch (e) {
    log(e.toString());
    final error = DataSource.noInternetConnection.getException();
    throw ServerException(error.message);
  } catch (e) {
    if (e is int) {
      final error = ErrorHandler.fromStatusCode(e).exception;
      throw ServerException(error.message);
    }
    final error = ErrorHandler.fromObject(e).exception;
    throw ServerException(error.message);
  }
}
