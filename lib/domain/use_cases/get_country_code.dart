import 'package:dartz/dartz.dart';
import 'package:my_news/core/error/failures.dart';
import 'package:my_news/domain/repository/config_repository.dart';

class GetCountryCode {
  final ConfigRepository repository;

  GetCountryCode(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getCountryCode();
  }
}
