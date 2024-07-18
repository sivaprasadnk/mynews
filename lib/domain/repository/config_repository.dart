import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';

abstract class ConfigRepository {
  Future<Either<Failure, String>> getCountryCode();
}
