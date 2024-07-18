import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/data/data_source/remote_config_data_source.dart';
import 'package:news_app/domain/repository/config_repository.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final FirebaseRemoteConfigDataSource remoteDataSource;

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
