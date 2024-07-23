import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';

abstract class RealtimeDbRepository {
  Future<Either<Failure, String>> getCountryCode();
  Future<Either<Failure, String>> getApiKey();
  Future<Either<Failure, Map>> getDetails();
  Future<Either<Failure, void>> setCountryCode(String code);
}
