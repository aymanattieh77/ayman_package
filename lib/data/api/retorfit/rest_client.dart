import 'package:ayman_package/data/api/endpoints.dart';
import 'package:ayman_package/domain/models/news/news.dart';
import 'package:ayman_package/domain/models/posts.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(Endpoints.everything)
  Future<NewsResponse> getNewsBySearch(@Query("q") String query,
      [@Query("apiKey") String apiKey = Endpoints.apiKey]);
}
