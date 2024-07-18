import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/data/data_source/news_remote_data_source.dart';
import 'package:news_app/domain/entity/news.dart';
import 'package:news_app/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<News>>> getNews(String country) async {
    try {
      final news = await remoteDataSource.getNews(country);
      return Right(news);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
