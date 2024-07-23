import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/entity/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews(String country, String apiKey);
}
