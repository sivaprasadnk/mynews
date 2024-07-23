import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/exceptions.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/data/data_source/news_remote_data_source.dart';
import 'package:my_news/domain/entity/news.dart';
import 'package:my_news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<News>>> getNews(
      String country, String apiKey) async {
    try {
      final news = await remoteDataSource.getNews(country, apiKey);
      return Right(news);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
