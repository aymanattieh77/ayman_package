import 'package:ayman_package/data/api/retorfit/rest_client.dart';
import 'package:ayman_package/data/errors/error_handler.dart';
import 'package:ayman_package/domain/models/news/news.dart';

class BaseRemoteDataSource {
  final RestClient _restClient;
  BaseRemoteDataSource(this._restClient);
  Future<NewsResponse> getNewsBySearch(String search) async {
    try {
      return await _restClient.getNewsBySearch(search);
    } catch (e) {
      throw ErrorHandler.fromObject(e).exception;
    }
  }
}
