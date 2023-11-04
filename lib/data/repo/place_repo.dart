import 'dart:developer';

import 'package:ayman_package/data/api/data_source/remote_data_source.dart';
import 'package:ayman_package/data/api/response/response.dart';
import 'package:ayman_package/data/errors/exceptions.dart';
import 'package:ayman_package/data/errors/failures.dart';
import 'package:ayman_package/domain/models/news/article.dart';
import 'package:ayman_package/domain/models/news/news.dart';
import 'package:ayman_package/domain/models/posts.dart';
import 'package:ayman_package/functions/popup_messages.dart';

class PlaceRepo {
  final BaseRemoteDataSource _dataSource;
  PlaceRepo(this._dataSource);

  Future<Status<Failure, List<Article>>> getNewsBySearch(String search) async {
    try {
      final response = await _dataSource.getNewsBySearch(search);

      return Right(response.articles ?? []);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
