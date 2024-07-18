import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/exceptions.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/data/data_source/remote_config_data_source.dart';
import 'package:my_news/domain/repository/config_repository.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final RemoteConfigDataSource remoteDataSource;

  ConfigRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> getCountryCode() async {
    try {
      final countryCode = await remoteDataSource.getCountryCode();
      return Right(countryCode);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
