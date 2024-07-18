import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/entity/news.dart';
import 'package:my_news/domain/repository/news_repository.dart';

class GetNews {
  final NewsRepository repository;

  GetNews(this.repository);

  Future<Either<Failure, List<News>>> call(String countryCode) async {
    return await repository.getNews(countryCode);
  }
}
