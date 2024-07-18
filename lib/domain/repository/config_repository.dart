import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';

abstract class ConfigRepository {
  Future<Either<Failure, String>> getCountryCode();
}
