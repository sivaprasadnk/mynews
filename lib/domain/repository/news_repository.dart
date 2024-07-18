import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/domain/entity/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews(String country);
}
