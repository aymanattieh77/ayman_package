import 'package:ayman_package/data/api/dio/dio_controller.dart';
import 'package:ayman_package/data/api/endpoints.dart';
import 'package:ayman_package/data/api/response/response.dart';
import 'package:ayman_package/data/errors/exceptions.dart';

abstract class APIService {
  Future<ApiResponse> getPosts();
}

class APIServiceImpl implements APIService {
  final DioController _apiController;
  APIServiceImpl(this._apiController);
  @override
  Future<ApiResponse> getPosts() async {
    try {
      final response = await _apiController.get(Endpoints.posts);
      return ApiResponse.completed(response.data);
    } on ServerException catch (e) {
      return ApiResponse.error(e.message);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
