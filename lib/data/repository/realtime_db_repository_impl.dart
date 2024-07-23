import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/exceptions.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/data/data_source/realtime_db_data_source.dart';
import 'package:my_news/domain/repository/realtime_db_repository.dart';

class RealtimeDbRepositoryImpl implements RealtimeDbRepository {
  final RealtimeDatabaseDataSourceImpl datasource;
  RealtimeDbRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, String>> getCountryCode() async {
    try {
      final countryCode = await datasource.getCountryCode();
      return Right(countryCode);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setCountryCode(String code) async {
    try {
      await datasource.setCountryCode(code);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getApiKey() async {
    try {
      final countryCode = await datasource.getApiKey();
      return Right(countryCode);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map>> getDetails() async {
    try {
      final details = await datasource.getDetails();
      return Right(details);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
